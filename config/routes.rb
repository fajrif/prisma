Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  # =====================================================
  # Legacy URL Redirects (WordPress migration)
  # These routes handle old URLs that return 500 errors
  # =====================================================

  # Legacy blog posts: /YYYY/MM/DD/slug/ -> /articles/:slug
  get '/:year/:month/:day/*path', to: 'redirects#legacy_blog',
                                  constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ }

  # Legacy works pages: /works/:slug -> /campaigns/:slug
  get '/works/*slug', to: 'redirects#legacy_works'

  # Legacy WordPress uploads: /wp-content/* -> 410 Gone
  get '/wp-content/*path', to: 'redirects#legacy_wp_content'

  # Legacy specific pages that need redirects
  get '/metaled', to: 'redirects#legacy_page', defaults: { slug: 'metaled' }
  get '/perbedaan-ooh-dooh', to: 'redirects#legacy_page', defaults: { slug: 'perbedaanoohdooh' }
  get '/3-inovasi-paling-diminati', to: 'redirects#legacy_page', defaults: { slug: '3inovasippalingdiminati' }
  get '/3-lokasi-strategis-ooh', to: 'redirects#legacy_page', defaults: { slug: '3lokasistrategisooh' }
  get '/inovasi-kunci-ooh', to: 'redirects#legacy_page', defaults: { slug: 'inovasikunciooh' }
  get '/brin-grande-led', to: 'redirects#legacy_page', defaults: { slug: 'bringrandeled' }
  get '/led-teuku-umar', to: 'redirects#legacy_page', defaults: { slug: 'ledtekukumar' }
  get '/led-braga', to: 'redirects#legacy_page', defaults: { slug: 'ledbraga' }
  get '/billboard-jakarta-capai-jutaan-penglihatan-bersama-prisma-advertising', to: 'redirects#legacy_page',
                                                                                defaults: { slug: 'billboard' }

  # Redirect malformed /id/cn/* URLs to /cn/* (fix for hreflang issues)
  get '/id/cn(/*path)', to: redirect { |params, _request| "/cn/#{params[:path]}" }

  # Legacy WordPress slug pages that were previously returning 500
  get '/about', to: 'redirects#legacy_page', defaults: { slug: 'about' }
  get '/contact', to: 'redirects#legacy_page', defaults: { slug: 'contact' }
  get '/work', to: 'redirects#legacy_page', defaults: { slug: 'work' }
  get '/product', to: 'redirects#legacy_page', defaults: { slug: 'product' }, as: :legacy_product
  get '/pix-animation', to: 'redirects#legacy_page', defaults: { slug: 'pixanimation' }
  get '/inovasi-real-time-live-stream', to: 'redirects#legacy_page', defaults: { slug: 'inivasirealtimestream' }
  get '/3-fakta-chase-smart-led', to: 'redirects#legacy_page', defaults: { slug: '3faktachasesmartled' }
  get '/multi-channel-ooh', to: 'redirects#legacy_page', defaults: { slug: 'multichannlooh' }
  get '/prisma-advertising-jasa-billboard-jakarta-harga-murah-desain-menarik', to: 'redirects#legacy_page',
                                                                               defaults: { slug: 'jasabillboardjakarta' }

  # Endpoint laporan pelanggaran Content-Security-Policy (mode report-only)
  post '/csp-violation-report', to: 'csp_reports#create'

  # Sitemap dibangkitkan dari database (T9). Harus di luar dan sebelum `scope '(:locale)'`,
  # kalau tidak `match ':id'` menangkapnya sebagai halaman CMS. File statis lama di
  # public/ sudah dihapus: middleware static Rails melayaninya lebih dulu dari route ini.
  get 'sitemap.xml', to: 'sitemaps#index', defaults: { format: 'xml' }, as: :sitemap
  get 'sitemap-:section.xml', to: 'sitemaps#show', defaults: { format: 'xml' },
                              constraints: { section: /pages|locations|billboards|articles/ }
  # Nama file lama Pro-Sitemaps, mungkin masih terdaftar di Search Console.
  get 'sitemap_4629941.xml', to: redirect('/sitemap.xml', status: 301)

  # Dipakai redirect di dalam `scope '(:locale)'`: mengembalikan '' untuk bahasa default
  # (en) dan '/id' atau '/cn' untuk lainnya, supaya redirect tidak melempar antar-bahasa.
  locale_prefix_for = ->(params) { params[:locale].present? ? "/#{params[:locale]}" : '' }

  scope '(:locale)', locale: /id|cn/ do
    namespace :admins do
      # Form "SEO & Social" terpisah (Admins::SeoEditable) dan blok FAQ/tabel (Admins::ContentBlocksController)
      concern :seo_editable do
        member do
          get :seo, action: :edit_seo
          patch :seo, action: :update_seo
        end
      end
      concern :content_blockable do
        resources :content_blocks, controller: '/admins/content_blocks', only: %i[new create edit update destroy]
      end

      root to: 'dashboard#index'

      # SEO
      resources :schema_markups do
        collection do
          get :schemable_records
        end
      end
      resource :setting, only: %i[show edit update] do
        patch :identity
      end
      resource :seo_audit, only: %i[show create] do
        get :download
      end
      get 'account/change_password' => 'accounts#change_password', :as => :change_password
      put 'account/update_password' => 'accounts#update_password', :as => :update_password

      resources :admins

      get 'link_buttons/objectable_types' => 'link_buttons#objectable_types', :as => :link_button_objectable_types

      resources :menus
      resources :addresses do
        collection do
          patch :sort
        end
      end
      resources :clients
      resources :testimonials
      resources :careers do
        member do
          delete 'delete_attachment/:asset_id' => 'careers#delete_attachment', :as => :delete_attachment
        end
      end
      resources :applications, only: %i[index show destroy]
      resources :banner_sections
      resources :banners do
        resources :link_buttons, controller: 'banners/link_buttons', except: %i[index show]
      end
      resources :articles, concerns: %i[seo_editable content_blockable] do
        member do
          delete 'delete_attachment/:asset_id' => 'articles#delete_attachment', :as => :delete_attachment
          delete 'delete_attachment_image/:asset_id' => 'articles#delete_attachment_image',
                 :as => :delete_attachment_image
        end
      end
      resources :categories
      resources :portfolios, concerns: :seo_editable
      resources :locations, concerns: %i[seo_editable content_blockable]
      resources :areas, concerns: %i[seo_editable content_blockable]
      resources :products, concerns: %i[seo_editable content_blockable] do
        member do
          delete 'delete_attachment/:name' => 'products#delete_attachment', :as => :delete_attachment
        end
      end
      resources :product_categories
      resources :awards
      resources :award_categories
      resources :pix_services
      resources :innovations
      resources :boostad_services
      resources :services, concerns: :seo_editable do
        resources :segments, controller: 'services/segments', except: [:index] do
          collection do
            patch :sort
          end
        end
        resources :benefits, controller: 'services/benefits', except: [:index]
      end
      resources :industries, concerns: %i[seo_editable content_blockable]
      resources :inquiries, only: %i[index show destroy]
      resources :pages, concerns: :seo_editable do
        resources :sections, controller: 'pages/sections', except: [:index] do
          collection do
            patch :sort
          end
        end
        resources :banners, controller: 'pages/banners', only: [:destroy] do
          collection do
            patch :sort
          end
        end
      end
      resources :snippets do
        resources :link_buttons, controller: 'snippets/link_buttons', except: %i[index show]
        resources :faq_items, controller: 'snippets/faq_items', except: %i[index show]
        member do
          delete 'delete_attachment/:asset_id' => 'snippets#delete_attachment', :as => :delete_attachment
        end
      end
    end

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # i18n Scope for id

    resources :inquiries, only: [:create]
    resources :articles, only: %i[index show]
    resources :services, only: [:show]
    resources :industries, only: %i[index show]
    resources :portfolios, only: %i[index show], path: 'campaigns'
    resources :careers, only: %i[show create]
    # --- Redirect URL lama, satu rilis bersama rename di bawah ---
    # Harus dideklarasikan SEBELUM `resources :locations`, karena /locations/:id
    # akan menangkap 'jabodetabek' lebih dulu dan membalas 404.
    # Query ?billboard_type= dipertahankan sesuai permintaan client.
    get '/locations/jabodetabek', to: redirect(status: 301) { |params, request|
      target = "#{locale_prefix_for.call(params)}/locations/jakarta"
      request.query_string.present? ? "#{target}?#{request.query_string}" : target
    }
    # URL billboard lama: /products/:slug (WordPress) dan /billboards/:slug (8–14 Okt 2026).
    # Keduanya 301 satu hop ke URL bertingkat yang dihitung dari data (area bisa berubah).
    get '/products/:id', to: 'redirects#billboard'
    get '/billboards/:id', to: 'redirects#billboard'

    resources :locations, only: %i[index show]
    # Halaman area dan halaman titik billboard (disetujui user 2026-10-13):
    # /locations/jakarta/jakarta-pusat dan /locations/jakarta/jakarta-pusat/{slug}.
    get '/locations/:location_id/:id', to: 'areas#show', as: :area
    get '/locations/:location_id/:area_id/:id', to: 'products#show', as: :billboard

    # URL lama yang masih dikunjungi di ketiga bahasa. Harus sebelum catch-all
    # `match ':id'`, kalau tidak akan dicari sebagai halaman CMS dan balas 404.
    get 'products', to: 'redirects#legacy_page', defaults: { slug: 'products' }
    get 'blog', to: 'redirects#legacy_page', defaults: { slug: 'blog' }
    get 'career', to: 'redirects#legacy_page', defaults: { slug: 'career' }

    # route to pages
    match 'contact-us', to: 'inquiries#show', via: :get, as: :contact_us
    match ':id', to: 'pages#show', via: :get, as: :page
    match '/404', to: 'errors#show', code: 404, via: :all
    match '/500', to: 'errors#show', code: 500, via: :all
    root to: 'pages#show', id: 'home'
  end
end

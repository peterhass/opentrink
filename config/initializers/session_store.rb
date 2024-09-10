Rails.application.config.session_store :active_record_store, key: 'opentrink_session', expire_after: 5.months
ActiveRecord::SessionStore::Session.serializer = :json

package com.all.med.allmed.allmed

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("YOUR_API_KEY") // Ваш сгенерированный API ключ
    }
}

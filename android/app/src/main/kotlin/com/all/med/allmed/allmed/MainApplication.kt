package com.all.med.allmed.allmed

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("16b2018c-25bf-4b82-9e34-68dae0c12367") // Ваш сгенерированный API ключ
    }
}

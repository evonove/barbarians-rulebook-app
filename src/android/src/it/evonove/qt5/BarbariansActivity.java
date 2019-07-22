package it.evonove.qt5;

import it.evonove.barbarians.R;
import android.app.Activity;
import android.os.Bundle;

public class BarbariansActivity extends org.qtproject.qt5.android.bindings.QtActivity
{
    public BarbariansActivity()
    {
        super();

        // here we override the default theme with our own
        // which allows us to set status bar color and
        // notification bar color
        QT_ANDROID_THEMES = new String[] {"BarbariansTheme"};
        QT_ANDROID_DEFAULT_THEME = "BarbariansTheme";
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        setTheme(R.style.BarbariansTheme);
        super.onCreate(savedInstanceState);
    }
}

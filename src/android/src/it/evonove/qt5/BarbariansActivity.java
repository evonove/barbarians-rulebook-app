package it.evonove.qt5;

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
}

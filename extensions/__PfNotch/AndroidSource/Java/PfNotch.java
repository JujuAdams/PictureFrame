package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.R;

import android.app.Activity;
import android.view.DisplayCutout;
import android.view.WindowInsets;

public class PfNotch
{
	public void Init()
	{
		
    }

    private DisplayCutout GetCutout()
    {
		try
		{
			if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.P)
			{
				WindowInsets insets = RunnerActivity.CurrentActivity.getWindow().getDecorView().getRootWindowInsets();

				if (insets != null)
				{
					DisplayCutout cut = insets.getDisplayCutout();
					if (cut != null)
					{
						return cut;
					}
				}
			}
		}
		catch(Exception excep)
		{

		}

		return null;
    }

	public double NotchGetLeft()
	{
		DisplayCutout cut = GetCutout();

		if (cut == null)
		{
			return 0.0;
		}
		else
		{
			return cut.getSafeInsetLeft();
		}
	}

	public double NotchGetTop()
	{
		DisplayCutout cut = GetCutout();
		
		if (cut == null)
		{
			return 0.0;
		}
		else
		{
			return cut.getSafeInsetTop();
		}
	}

	public double NotchGetRight()
	{
		DisplayCutout cut = GetCutout();
		
		if (cut == null)
		{
			return 0.0;
		}
		else
		{
			return cut.getSafeInsetRight();
		}
	}

	public double NotchGetBottom()
	{
		DisplayCutout cut = GetCutout();
		
		if (cut == null)
		{
			return 0.0;
		}
		else
		{
			return cut.getSafeInsetBottom();
		}
	}
}
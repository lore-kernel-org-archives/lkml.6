Date: Tue, 6 Feb 2018 06:37:55 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kangmin Park <l4stpr0gr4m@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Resolve RF Type mismatch
Message-ID: <20180206143755.GA15843@kroah.com>
References: <CAKW4uUwhr4ypwQacnwQEEH0aZD+R2S_jMf+w2J9SdsPVBsziuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKW4uUwhr4ypwQacnwQEEH0aZD+R2S_jMf+w2J9SdsPVBsziuA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 10:39:45PM +0900, Kangmin Park wrote:
> Match rf_type of staging/rtlwifi/wifi.h and staging/rtl8723bs/include/rtw_rf.h,
> and update some additional code that resulted.
> 
> Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
> 
> diff --git a/drivers/staging/rtl8723bs/hal/odm.h
> b/drivers/staging/rtl8723bs/hal/odm.h
> index 87a76ba..dbb78fe 100644
> --- a/drivers/staging/rtl8723bs/hal/odm.h
> +++ b/drivers/staging/rtl8723bs/hal/odm.h
> @@ -511,14 +511,15 @@ typedef enum tag_ODM_RF_Path_Bit_Definition {
> 
> 
>  typedef enum tag_ODM_RF_Type_Definition {
> - ODM_1T1R = 0,
> - ODM_1T2R = 1,
> - ODM_2T2R = 2,
> - ODM_2T3R = 3,
> - ODM_2T4R = 4,
> - ODM_3T3R = 5,
> - ODM_3T4R = 6,
> - ODM_4T4R = 7,
> + ODM_1T1R = 0,
> + ODM_1T2R = 1,
> + ODM_2T2R = 2,
> + ODM_2T2R_GREEN = 3,
> + ODM_2T3R = 4,
> + ODM_2T4R = 5,
> + ODM_3T3R = 6,
> + ODM_3T4R = 7,
> + ODM_4T4R = 8,
>  } ODM_RF_TYPE_E;
> 
> 

Whitespace seems to be totally broken in your patch, making it
impossible to apply :(

Please try fixing up your email client and trying again.

Also, use the scripts/get_maintainer.pl tool on your patch to know what
mailing lists and people to cc: for a patch.

thanks,

greg k-h

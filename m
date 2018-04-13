Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbeDMIuv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:50:51 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:52268 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeDMIus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:50:48 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180413085046epoutp0259bb19e02d57126729ff9ed77993f5da~k8rgWWeX11518115181epoutp02c
X-AuditID: b6c32a38-d73ff70000001082-99-5ad06f664eb1
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 10:50:43 +0200
Message-id: <3639670.ds6gqUTXoT@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180413040855.GA29826@localhost.localdomain>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7bCmgW5a/oUog/u/uCzmX7nGanF51xw2
        i8+9RxgtLh26yGTx5GEfm8WjvrfsDmweO2fdZfdYvOclk8eJGb9ZPD5vkgtgieKySUnNySxL
        LdK3S+DKWHxwP1PBI+WKF9P/sTUwHpHpYuTkkBAwkbjfsoKti5GLQ0hgB6NET28blPOdUeLF
        6icsXYwcYFXveqxBGoQEdjNK7Gnygaj5yiix+v1ZVpAEm4CVxMT2VYwgtoiAlsSJS9uZQIqY
        BU4xSnRvucAEkhAWcJBo2HANbCiLgKrEkddgYV4BTYmTazrZQWxRAS+JLfvamUBKOAWsJSb0
        5kOUCEr8mHyPBcRmFpCX2Ld/KiuErSNx9tg6RpBVEgJb2CQ+/T3CBvGZi8Tq4+/ZIWxhiVfH
        t7BD/CItcemoLUR9M6PEtx17mCFqJgA9tl4IwraWOHz8ItQCPol3X3tYIXp5JTraoEo8JL5+
        v8kKYTtKfJ6/gQUSPlsZJRaelJrAKDsLydmzkJw9C8nZCxiZVzGKpRYU56anFhsWmOgVJ+YW
        l+al6yXn525iBKcCLYsdjHvO+RxiFOBgVOLhVag8HyXEmlhWXJl7iFGCg1lJhLdZ5kKUEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd6nPmeihATSE0tSs1NTC1KLYLJMHJxSDYwV6Xe2ub6YtnTx
        V6/2jT89gpeJKfd+e9y6guv6xZ3B/vfSfhZ2RUp9tt25Wc/nkkx936FEzX16Mpmv5t46yhJa
        n+shM+/4pz87szZYmBjWH+U/U2upzqmt1ca6SN4gqiPkjKjtpDLDTar/DyaG75wULlv3OCiK
        oWXZ68Aa3z3CWS6OjWv01ymxFGckGmoxFxUnAgBHytA2AQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jAd3U/AtRBuvu6FnMv3KN1eLyrjls
        Fp97jzBaXDp0kcniycM+NotHfW/ZHdg8ds66y+6xeM9LJo8TM36zeHzeJBfAEsVlk5Kak1mW
        WqRvl8CVsfjgfqaCR8oVL6b/Y2tgPCLTxcjBISFgIvGux7qLkYtDSGAno8SkHfdZIJyvjBK/
        pi9l7WLk5GATsJKY2L6KEcQWEdCSOHFpOxNIEbPAKUaJd32LWEASwgIOEg0brrGATGURUJU4
        8poJJMwroClxck0nO4gtKuAlsWVfOxNICaeAtcSE3nyIXVsZJS6f/8YMUS8o8WPyPbCRzALy
        Evv2T2WFsLUk1u88zjSBkX8WkrJZSMpmISlbwMi8ilEytaA4Nz232KjAMC+1XK84Mbe4NC9d
        Lzk/dxMjMIC3Hdbq28F4f0n8IUYBDkYlHl6FyvNRQqyJZcWVuYcYJTiYlUR4m2UuRAnxpiRW
        VqUW5ccXleakFh9ilOZgURLnvZ13LFJIID2xJDU7NbUgtQgmy8TBKdXA2GVRknauw+Kqsdlm
        Bt3ohum8ind51LKXHrzKH9/9niFravTTxFaPZ+sU93//FS87f9fuL9r3zpwMZY/6eukwQ9ec
        6PQjK/1D6g0cKmSuPCq6nr85b726cfMay7mn8v8pO2i66Kqm7VD7XFMkpnpw8d/YVbG8RbcF
        7daefxE9iSn9UPzdJxmhSizFGYmGWsxFxYkAAiH2o1wCAAA=
X-CMS-MailID: 20180413085045epcas1p3477a28ac1b06792533cc86464b5564fa
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180413040901epcas4p1c3c515567fb6ab613c018cd7229c4bd4
X-RootMTR: 20180413040901epcas4p1c3c515567fb6ab613c018cd7229c4bd4
References: <1523436077.16235.5.camel@intel.com>
        <CGME20180413040901epcas4p1c3c515567fb6ab613c018cd7229c4bd4@epcas4p1.samsung.com>
        <20180413040855.GA29826@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday, April 12, 2018 09:08:57 PM Eduardo Valentin wrote:
> Hello,

Hi,

> On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> > On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> > >
> > > could you please illustrate me what the kconfig & warning is?
> > 
> > Just "make allmodconfig" and the warning is about a uninitialized variable.
> > 
> > Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell history
> > is to be believed.
> > 
> >                 Linus
> 
> Yeah, this has also passed my local compilation error. Somehow my gcc4.9
> is not catching it. Using an older gcc (gcc4.6) does catch it.
> 
> Anyways, given that the conversion functions are written to cover
> for unexpected cal_type, the right way of fixing this is to rewrite
> the conversion functions to allow for returning error codes and
> adjusting the callers as expected.
> 
> Rui, bzolnier, please consider the following fix:
> 
> From 2aaf94f80c0021a21b4122c9f4197acff08ea398 Mon Sep 17 00:00:00 2001
> From: Eduardo Valentin <edubezval@gmail.com>
> Date: Thu, 12 Apr 2018 21:00:48 -0700
> Subject: [PATCH 1/1] thermal: exynos: fix compilation warning around
>  conversion functions
> 
> In order to fix the warns:
> drivers/thermal/samsung/exynos_tmu.c:931:37: warning: 'temp' may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/thermal/samsung/exynos_tmu.c:304:9: warning: 'temp_code' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> the conversion functions should allow return error codes
> and the not mix the converted value with error code.
> 
> This patch change the conversion functions to return
> error code or success and adjusts the callers accordingly.
> 
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 120 ++++++++++++++++++++++++-----------
>  1 file changed, 84 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 2ec8548..b3f0704 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -282,52 +282,54 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
>   * TMU treats temperature as a mapped temperature code.
>   * The temperature is converted differently depending on the calibration type.
>   */
> -static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
> +static int temp_to_code(struct exynos_tmu_data *data, u8 temp, int *temp_code)
>  {
> -	int temp_code;
> +	int ret = 0;
>  
>  	switch (data->cal_type) {
>  	case TYPE_TWO_POINT_TRIMMING:
> -		temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
> +		*temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
>  			(data->temp_error2 - data->temp_error1) /
>  			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
>  			data->temp_error1;
>  		break;
>  	case TYPE_ONE_POINT_TRIMMING:
> -		temp_code = temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
> +		*temp_code = temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
>  		break;
>  	default:

Since this condition cannot happen (the driver makes sure of this during
probe) I would prefer much simpler fix from Arnd:

https://patchwork.kernel.org/patch/10313313/

(I've already ACKed it two weeks ago).

>  		WARN_ON(1);
> +		ret = -EINVAL;
>  		break;
>  	}
>  
> -	return temp_code;
> +	return ret;
>  }
>  
>  /*
>   * Calculate a temperature value from a temperature code.
>   * The unit of the temperature is degree Celsius.
>   */
> -static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
> +static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code, int *temp)
>  {
> -	int temp;
> +	int ret = 0;
>  
>  	switch (data->cal_type) {
>  	case TYPE_TWO_POINT_TRIMMING:
> -		temp = (temp_code - data->temp_error1) *
> +		*temp = (temp_code - data->temp_error1) *
>  			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
>  			(data->temp_error2 - data->temp_error1) +
>  			EXYNOS_FIRST_POINT_TRIM;
>  		break;
>  	case TYPE_ONE_POINT_TRIMMING:
> -		temp = temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
> +		*temp = temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
>  		break;
>  	default:
>  		WARN_ON(1);
> +		ret = -EINVAL;

ditto

>  		break;
>  	}
>  
> -	return temp;
> +	return ret;
>  }

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

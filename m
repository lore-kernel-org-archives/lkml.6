Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeEBPtm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:49:42 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39800 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeEBPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:49:36 -0400
X-Google-Smtp-Source: AB8JxZoMWMzefU2UFnS5q/freDNNFC1ge1YxncrRNRdDDSlJieepwYcWLEkbxRpkkkBb+kKCZvuthw==
Date: Wed, 2 May 2018 17:49:31 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: ti-soc-thermal: fix incorrect entry in
 omap5430_adc_to_temp[]
Message-ID: <20180502154931.GS27619@mai>
References: <CGME20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6@eucas1p1.samsung.com>
 <17742083.Vu59BImYbG@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17742083.Vu59BImYbG@amdc3058>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 04:14:32PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Entry for Index 941 has one zero too much. Fix it.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Good catch :)

I'm curious, how did you spot it ?

> ---
> v2:
> - Fix patch description.
> 
>  drivers/thermal/ti-soc-thermal/omap5-thermal-data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
> ===================================================================
> --- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c	2018-04-30 16:23:42.000000000 +0200
> +++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c	2018-05-02 14:16:09.461434201 +0200
> @@ -310,7 +310,7 @@ omap5430_adc_to_temp[
>  	119800, 120200, 120600, 121000, 121400, 121800, 122400, 122600, 123000,
>  	123400,
>  	/* Index 940 - 945 */
> -	123800, 1242000, 124600, 124900, 125000, 125000,
> +	123800, 124200, 124600, 124900, 125000, 125000,
>  };
>  
>  /* OMAP54xx ES2.0 data */
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

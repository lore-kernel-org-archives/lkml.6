Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeEBPog (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:44:36 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:41432 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeEBPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:44:32 -0400
Subject: Re: [PATCH v2] thermal: ti-soc-thermal: fix incorrect entry in
 omap5430_adc_to_temp[]
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
CC: Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <CGME20180502141432eucas1p1c85aa366979b73c59a46ec0c2f7ef8e6@eucas1p1.samsung.com>
 <17742083.Vu59BImYbG@amdc3058>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <fb498dba-cbd6-c2b6-2152-a6d51284f936@ti.com>
Date: Wed, 2 May 2018 21:14:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <17742083.Vu59BImYbG@amdc3058>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 02 May 2018 07:44 PM, Bartlomiej Zolnierkiewicz wrote:
> Entry for Index 941 has one zero too much. Fix it.
> 

Acked-by: Keerthy <j-keerthy@ti.com>

> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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

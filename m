Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754619AbeDPMuh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:50:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35829 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754314AbeDPMue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:50:34 -0400
X-Google-Smtp-Source: AIpwx4+tE4ArPYKJQRjASkOYHicxEKSMxMP+ll351vvWEvDN79ocFvl0AOSacmwvYohX8zLQBaEZjA==
Subject: Re: [PATCH 04/14] thermal: exynos: remove unused "type" field from
 struct exynos_tmu_platform_data
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101357epcas2p16992f345f7dcebd90e3d4e50afbeeb88@epcas2p1.samsung.com>
 <1523873525-23718-5-git-send-email-b.zolnierkie@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <91cb32b9-e05d-cbee-27cc-1e13eb79a0a1@linaro.org>
Date: Mon, 16 Apr 2018 14:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523873525-23718-5-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> Remove unused "type" field from struct exynos_tmu_platform_data.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


>  drivers/thermal/samsung/exynos_tmu.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
> index 5149c2a..8c468b6 100644
> --- a/drivers/thermal/samsung/exynos_tmu.h
> +++ b/drivers/thermal/samsung/exynos_tmu.h
> @@ -47,7 +47,6 @@ enum soc_type {
>   *	0 < reference_voltage <= 31
>   * @noise_cancel_mode: noise cancellation mode
>   *	000, 100, 101, 110 and 111 can be different modes
> - * @type: determines the type of SOC
>   * @efuse_value: platform defined fuse value
>   * @min_efuse_value: minimum valid trimming data
>   * @max_efuse_value: maximum valid trimming data
> @@ -68,7 +67,6 @@ struct exynos_tmu_platform_data {
>  	u8 second_point_trim;
>  	u8 default_temp_offset;
>  
> -	enum soc_type type;
>  	u32 cal_type;
>  };
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

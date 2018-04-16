Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754919AbeDPNPi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:15:38 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42700 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbeDPNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:15:36 -0400
X-Google-Smtp-Source: AIpwx4/RQWhH6JjoQi94Wbbgxdj8Xg8x4q8AwRHOCiu3wOuS9bNaPajry4taUKkoEVFAR/0JSU4hpA==
Subject: Re: [PATCH 08/14] thermal: exynos: remove parsing of
 samsung,tmu[_min,_max]_efuse_value properties
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101409epcas1p4f8e0279a94322d1cc423ced6dfce3362@epcas1p4.samsung.com>
 <1523873525-23718-9-git-send-email-b.zolnierkie@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <79d94b60-3dec-c4bf-6df4-5a4f1319760c@linaro.org>
Date: Mon, 16 Apr 2018 15:15:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523873525-23718-9-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> Since pdata efuse values are SoC (not platform) specific just move
> them from platform data to struct exynos_tmu_data instance. Then
> remove parsing of samsung,tmu[_,min_,max]_efuse_value properties.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 49 +++++++++++++++++++++++-------------
>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

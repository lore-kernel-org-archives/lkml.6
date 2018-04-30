Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeD3PhJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:37:09 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45520 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753754AbeD3PhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:37:07 -0400
X-Google-Smtp-Source: AB8JxZqX2PbR7WKNtD1gA8ESwIAkE42NG+8EhDXK6IhhYMFoq2MWr0MDEm/OSyd65q2zUJowYPzD0A==
Date: Mon, 30 Apr 2018 17:37:03 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/18] thermal: exynos: remove threshold_code checking
 from exynos4210_tmu_initialize()
Message-ID: <20180430153703.GC27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115216epcas1p3ed61f0fd8563e7ea72f3d7d17c9c039f@epcas1p3.samsung.com>
 <1524743493-28113-8-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524743493-28113-8-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:22PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Exynos4210 one-point trimming is always used and data->temp_error1
> is equal to 75. Therefore temp_to_code() will never return negative
> value for the reference temperature conversion.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 6 +-----
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

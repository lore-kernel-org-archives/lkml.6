Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754744AbeD3Pa7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:30:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50228 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754665AbeD3Pa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:30:56 -0400
X-Google-Smtp-Source: AB8JxZoOpF20xN9FbMxZ3WbJpPWdPzvkm7qLozhQPmE74+Gm/TGqq8V3mcKpXzNVVJBglBUz8XC9HQ==
Date: Mon, 30 Apr 2018 17:30:53 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] thermal: exynos: use sanitize_temp_error() in
 exynos7_tmu_initialize()
Message-ID: <20180430153053.GA27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115211epcas1p3db7cbe215a3dfb49567a771931574a2f@epcas1p3.samsung.com>
 <1524743493-28113-6-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524743493-28113-6-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:20PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Fix sanitize_temp_error() to handle Exynos7 SoCs and then use it in
> exynos7_tmu_initialize().
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

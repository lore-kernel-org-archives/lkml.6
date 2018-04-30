Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754415AbeD3Oru (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:47:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37835 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbeD3Ors (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:47:48 -0400
X-Google-Smtp-Source: AB8JxZoMDcMbeh6Okg5kUu87BY8Y3piJPprwtDpDSH7WyFuWY/ERG/wdyVizLQ3h9WI02HAKv8fa/w==
Date: Mon, 30 Apr 2018 16:47:44 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] thermal: exynos: move IRQs clearing to
 exynos_tmu_initialize()
Message-ID: <20180430144744.GK11457@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115224epcas1p3dde7044de7d11c7ec7a7411df1123552@epcas1p3.samsung.com>
 <1524743493-28113-11-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524743493-28113-11-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:25PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Move ->tmu_clear_irqs call from ->tmu_initialize method to
> exynos_tmu_initialize().
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

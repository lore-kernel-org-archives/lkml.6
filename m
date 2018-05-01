Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeEAJ7q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:59:46 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:39977 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeEAJ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:59:44 -0400
X-Google-Smtp-Source: AB8JxZpQ4bj+Yx1umPeIUHPpAGHafX1l6SBZPGhh8Y+q7yHkVwE+6sXuN/lhPl6Wab6gEMYmJHSPZQ==
Date: Tue, 1 May 2018 11:59:40 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/18] thermal: exynos: do not use trips structure
 directly in ->tmu_initialize
Message-ID: <20180501095940.GI27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115229epcas1p42ebcc547531485a4f30284dd3be7e43a@epcas1p4.samsung.com>
 <1524743493-28113-13-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524743493-28113-13-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Use ->get_trip_[temp,hyst] methods instead of using trips structure
> directly in all ->tmu_initialize method implementations.
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

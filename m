Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeDKGSz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:18:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37382 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeDKGSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:18:54 -0400
X-Google-Smtp-Source: AIpwx4+YZ1QGe7l6U/y9WY2l6h/+EXNsJ2a9xCEmuxiYosxqOmsjwJL84gG7uWsvIFZJnONQ0uMCbw==
Date: Wed, 11 Apr 2018 11:48:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH v3 4/7] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Message-ID: <20180411061851.GM7671@vireshk-i7>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-5-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522945005-7165-5-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-04-18, 18:16, Daniel Lezcano wrote:
> The next changes will add new way to cool down a CPU. In order to
> sanitize and make the overall cpu cooling code consistent and robust
> we must prevent the cpu cooling devices to co-exists with the same
> purpose at the same time in the kernel.
> 
> Make the CPU cooling device a choice in the Kconfig, so only one CPU
> cooling strategy can be chosen.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig       | 20 +++++++++++++++++---
>  drivers/thermal/cpu_cooling.c |  2 ++
>  include/linux/cpu_cooling.h   |  6 +++---
>  3 files changed, 22 insertions(+), 6 deletions(-)

I don't see my review comments from V2 being addressed for this patch.
Can you please check that again ?

-- 
viresh

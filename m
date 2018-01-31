Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeAaFRp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 00:17:45 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43387 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeAaFRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 00:17:43 -0500
X-Google-Smtp-Source: AH8x226tmuuZgP8Qpi3+TXIPpXsgNicqzcGpHsEVK+rmJIAEdaCr6iUJWkEzMHCrNYHOSzCxN0g0tA==
Date: Wed, 31 Jan 2018 10:47:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/8] thermal/drivers/cpu_cooling: Fixup the header and
 copyright
Message-ID: <20180131051739.GG13395@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516721671-16360-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-18, 16:34, Daniel Lezcano wrote:
> The copyright format does not conform to the format requested by
> Linaro: https://wiki.linaro.org/Copyright
> 
> Fix it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index dc63aba..988fc55 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -2,9 +2,11 @@
>   *  linux/drivers/thermal/cpu_cooling.c
>   *
>   *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
> - *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>   *
> - *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
> + *  Copyright (C) 2018 Linaro Limited.
> + *

Shouldn't this be 2012-2018 ?

> + *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
> + *		Viresh Kumar <viresh.kumar@linaro.org>
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   *  This program is free software; you can redistribute it and/or modify
> -- 
> 2.7.4

-- 
viresh

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbeDKGPU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:15:20 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44102 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeDKGPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:15:18 -0400
X-Google-Smtp-Source: AIpwx48aAqQ6N+AKTXxAm5Gnkz+OSRsKyIFfnJFuRf73rNK3uGhUuuVF4GpowJ8E9inzFF9cukHFXA==
Date: Wed, 11 Apr 2018 11:45:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH v3 1/7] thermal/drivers/cpu_cooling: Fixup the header and
 copyright
Message-ID: <20180411061514.GL7671@vireshk-i7>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522945005-7165-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-04-18, 18:16, Daniel Lezcano wrote:
> The copyright format does not conform to the format requested by
> Linaro: https://wiki.linaro.org/Copyright
> 
> Fix it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

You forgot to include my Ack ?

> ---
>  drivers/thermal/cpu_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index dc63aba..42110ee 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -2,9 +2,11 @@
>   *  linux/drivers/thermal/cpu_cooling.c
>   *
>   *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
> - *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>   *
> - *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
> + *  Copyright (C) 2012-2018 Linaro Limited.
> + *
> + *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
> + *		Viresh Kumar <viresh.kumar@linaro.org>
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   *  This program is free software; you can redistribute it and/or modify
> -- 
> 2.7.4

-- 
viresh

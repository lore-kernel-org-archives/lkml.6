Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751063AbeEUFoP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 01:44:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41447 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeEUFoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 01:44:13 -0400
X-Google-Smtp-Source: AB8JxZoNY6ZGmq5UwX+n/q0kDDF7ib962oVbI7nmOQL+BNXf5mIbMPY26TkhpxfwZUIfVTeKSqwAEg==
Date: Mon, 21 May 2018 11:14:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v2 03/11] cpufreq: tegra20: Clean up included headers
Message-ID: <20180521054409.3n6z434de5ibzufq@vireshk-i7>
References: <20180518200642.24815-1-digetx@gmail.com>
 <20180518200642.24815-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518200642.24815-4-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-18, 23:06, Dmitry Osipenko wrote:
> Remove unused/unneeded headers and sort them in the alphabet order.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index dd8a76a64a8e..bec1a50a8138 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -16,16 +16,12 @@
>   *
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/sched.h>
> +#include <linux/clk.h>
>  #include <linux/cpufreq.h>
> -#include <linux/delay.h>
> -#include <linux/init.h>
>  #include <linux/err.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
>  
>  static struct cpufreq_frequency_table freq_table[] = {
>  	{ .frequency = 216000 },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

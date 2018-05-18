Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeERCAT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:00:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43391 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbeERCAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:00:16 -0400
X-Google-Smtp-Source: AB8JxZqwfKJJPUtwKCvduhV4wu2x1dvRKXDoAuM3LuijgAEEz4B/XAhlcLOIriz/bkJgyt8tAEZm9A==
Date: Fri, 18 May 2018 07:30:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 08/11] cpufreq: tegra20: Remove unneeded variable
 initialization
Message-ID: <20180518020013.dtklahhug5xzpksb@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-9-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> Remove unneeded variable initialization solely for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 797c61c74b65..c0a7b5a78aa6 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -84,7 +84,7 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
>  {
>  	unsigned long rate = freq_table[index].frequency;
>  	unsigned int ifreq = clk_get_rate(pll_p_clk) / 1000;
> -	int ret = 0;
> +	int ret;
>  
>  	/*
>  	 * target freq == pll_p, don't need to take extra reference to pll_x_clk

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

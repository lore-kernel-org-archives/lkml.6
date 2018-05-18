Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeERBx4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:53:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41190 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeERBxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:53:54 -0400
X-Google-Smtp-Source: AB8JxZpbuKA8yeYsXchBvrxRReenlC04/+LOagFNArlYJUS2plC63FNkkwx+1+MXpbYFCLc3DM65YQ==
Date: Fri, 18 May 2018 07:23:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 01/11] cpufreq: tegra20: Change module description
Message-ID: <20180518015350.5nihxltyxn5bhdho@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-2-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> Change module description to be in line with the other Tegra drivers, just
> for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 2bd62845e9d5..10793498355e 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -210,7 +210,7 @@ static void __exit tegra_cpufreq_exit(void)
>  
>  
>  MODULE_AUTHOR("Colin Cross <ccross@android.com>");
> -MODULE_DESCRIPTION("cpufreq driver for Nvidia Tegra2");
> +MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
>  MODULE_LICENSE("GPL");
>  module_init(tegra_cpufreq_init);
>  module_exit(tegra_cpufreq_exit);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

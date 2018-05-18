Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeERByR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:54:17 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45655 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeERByP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:54:15 -0400
X-Google-Smtp-Source: AB8JxZr4rM0yDok/N+G82IBozF8KYivRYwiMsQuKWjpUMkBI9X5q2pVBIPWwpyzFC/4p31rwo9K7gQ==
Date: Fri, 18 May 2018 07:24:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 02/11] cpufreq: tegra20: Clean up whitespaces in the
 code
Message-ID: <20180518015411.y73hjkjjafxtar65@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-3-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> Remove unneeded blank line and replace whitespaces with a tab in the code
> for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 10793498355e..dd8a76a64a8e 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -203,12 +203,11 @@ static int __init tegra_cpufreq_init(void)
>  
>  static void __exit tegra_cpufreq_exit(void)
>  {
> -        cpufreq_unregister_driver(&tegra_cpufreq_driver);
> +	cpufreq_unregister_driver(&tegra_cpufreq_driver);
>  	clk_put(emc_clk);
>  	clk_put(cpu_clk);
>  }
>  
> -
>  MODULE_AUTHOR("Colin Cross <ccross@android.com>");
>  MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
>  MODULE_LICENSE("GPL");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

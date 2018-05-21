Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeEUFop (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 01:44:45 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41070 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeEUFol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 01:44:41 -0400
X-Google-Smtp-Source: AB8JxZq3mVci5A77L1hoX3mZLHyTQ6aYvlyC52NutZlYGjm7Wf+YtVMe8Eqt+jFdKuzXcZy7cGSW6A==
Date: Mon, 21 May 2018 11:14:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v2 07/11] cpufreq: tegra20: Remove unnecessary parentheses
Message-ID: <20180521054438.hvv4rlc5bu6jjlbo@vireshk-i7>
References: <20180518200642.24815-1-digetx@gmail.com>
 <20180518200642.24815-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518200642.24815-8-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-18, 23:06, Dmitry Osipenko wrote:
> Remove unnecessary parentheses as suggested by the checkpatch script.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index df25e350c8e6..4b85a6733533 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -50,7 +50,7 @@ static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
>  	 * - we are already at it, i.e. policy->cur == ifreq
>  	 * - index corresponds to ifreq
>  	 */
> -	if ((freq_table[index].frequency == ifreq) || (policy->cur == ifreq))
> +	if (freq_table[index].frequency == ifreq || policy->cur == ifreq)
>  		return 0;
>  
>  	return ifreq;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeERHa4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:30:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61901 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeERHaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:30:55 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 00/11] Clean up Tegra20 cpufreq driver
Date: Fri, 18 May 2018 09:30:19 +0200
Message-ID: <33210093.0R9M0pnSOk@aspire.rjw.lan>
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 17, 2018 8:00:45 PM CEST Dmitry Osipenko wrote:
> Hello,
> 
> Recently Peter Geis (who is working on Tegra30 cpufreq driver) asked me how
> tegra20-cpufreq driver is getting loaded. After taking a look at the code
> it became apparent that the drivers code has been rusted a tad and so this
> series is intended to refresh the drivers code by disallowing module to be
> loaded on non-Tegra20 machines, by cleaning whitespaces in the code, removing
> dead EMC code and in the end by allowing tegra20-cpufreq to be built as a
> loadable module.
> 
> Please review, thanks.
> 
> Dmitry Osipenko (11):
>   cpufreq: tegra20: Change module description
>   cpufreq: tegra20: Clean up whitespaces in the code
>   cpufreq: tegra20: Remove EMC clock usage
>   cpufreq: tegra20: Release clocks properly
>   cpufreq: tegra20: Clean up included headers
>   cpufreq: tegra20: Remove unneeded check in tegra_cpu_init
>   cpufreq: tegra20: Check if this is Tegra20 machine
>   cpufreq: tegra20: Remove unneeded variable initialization
>   cpufreq: tegra20: Allow cpufreq driver to be built as loadable module
>   cpufreq: tegra20: Wrap cpufreq into platform driver
>   ARM: tegra: Create platform device for tegra20-cpufreq driver
> 
>  arch/arm/mach-tegra/tegra.c       |   4 +
>  drivers/cpufreq/Kconfig.arm       |   2 +-
>  drivers/cpufreq/tegra20-cpufreq.c | 172 +++++++++++++++++-------------
>  3 files changed, 101 insertions(+), 77 deletions(-)
> 
> 

It looks like Viresh has ACKed the majority of the patches in this series,
but there are a few where he had comments.

Please fix up these and resend the entire series with the Acked-by tags from
Viresh added where applicable.

Thanks,
Rafael

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932387AbeCOCrk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:47:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40118 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932364AbeCOCrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:47:37 -0400
X-Google-Smtp-Source: AG47ELvT1hzHP7UZIYyu4FfsI2KwL+oGF/w3KcG13b2uk8gc7HhBCrgERSNA/XKylfDThPvxV/M+Cg==
Date: Thu, 15 Mar 2018 08:17:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 23/47] cpufreq: remove cris specific drivers
Message-ID: <20180315024732.GI15832@vireshk-i7>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-24-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-24-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-18, 16:35, Arnd Bergmann wrote:
> The cris architecture is getting removed, including the artpec3
> and etraxfs SoCs, so these cpufreq drivers are now unused.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Makefile               |  2 -
>  drivers/cpufreq/cris-artpec3-cpufreq.c | 93 ----------------------------------
>  drivers/cpufreq/cris-etraxfs-cpufreq.c | 92 ---------------------------------
>  3 files changed, 187 deletions(-)
>  delete mode 100644 drivers/cpufreq/cris-artpec3-cpufreq.c
>  delete mode 100644 drivers/cpufreq/cris-etraxfs-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 2e4495cf9aa8..8d24ade3bd02 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -102,8 +102,6 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
>  ##################################################################################
>  # Other platform drivers
>  obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
> -obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
> -obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
>  obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
>  obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
>  obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
> diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
> deleted file mode 100644
> index 455b4fb78cba..000000000000
> diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
> deleted file mode 100644
> index 4c4b5dd685e3..000000000000

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

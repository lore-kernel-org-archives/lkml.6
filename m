Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeCOMTb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:19:31 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:58139 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCOMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:19:29 -0400
Date: Thu, 15 Mar 2018 13:19:27 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 23/47] cpufreq: remove cris specific drivers
Message-ID: <20180315121927.GS17177@axis.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-24-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-24-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 04:35:36PM +0100, Arnd Bergmann wrote:
> The cris architecture is getting removed, including the artpec3
> and etraxfs SoCs, so these cpufreq drivers are now unused.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

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
> -- 
> 2.9.0

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeCOCrY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:47:24 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35373 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbeCOCrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:47:23 -0400
X-Google-Smtp-Source: AG47ELtXxQCRUpFrrb+8yVyS1N3yFfFXtJb8tGj0u0GchLxZlFmCFDgG3uy6FZUZcpw3dV2dXScK6A==
Date: Thu, 15 Mar 2018 08:17:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 22/47] cpufreq: remove blackfin driver
Message-ID: <20180315024718.GH15832@vireshk-i7>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-23-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-23-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-18, 16:35, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this driver is
> now obsolete.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Makefile           |   1 -
>  drivers/cpufreq/blackfin-cpufreq.c | 217 -------------------------------------
>  2 files changed, 218 deletions(-)
>  delete mode 100644 drivers/cpufreq/blackfin-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 4987227b67df..2e4495cf9aa8 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -101,7 +101,6 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
>  
>  ##################################################################################
>  # Other platform drivers
> -obj-$(CONFIG_BFIN_CPU_FREQ)		+= blackfin-cpufreq.o
>  obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
>  obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
>  obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
> diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
> deleted file mode 100644
> index 12e97d8a9db0..000000000000

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

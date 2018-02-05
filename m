Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbeBEEFZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 23:05:25 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46583 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeBEEFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 23:05:18 -0500
X-Google-Smtp-Source: AH8x224toKlr/EUcswGjqyX7C3aBNnbKwwsDxai8fZxtflRryAH9hLaUa6JTm/aWFVD+eVl4ZqpY5w==
Date: Mon, 5 Feb 2018 09:35:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Christophe Leroy <christophe.leroy@c-s.fr>, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 03/20] kconfig: Remove leftover references to AVR32 symbol
Message-ID: <20180205040515.GC28462@vireshk-i7>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-4-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205012146.23981-4-ulfalizer@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-02-18, 02:21, Ulf Magnusson wrote:
> The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
> support for AVR32 architecture"). Remove the remaining references to it
> from the Kconfig files.
> 
> No references remain to the removed AVR32_AT32AP_CPUFREQ symbol either,
> so remove that one too.
> 
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  drivers/cpufreq/Kconfig       | 10 ----------
>  drivers/pwm/Kconfig           |  2 +-
>  drivers/spi/Kconfig           |  2 +-
>  drivers/video/console/Kconfig |  2 +-
>  4 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index d8addbce40bc..608af20a3494 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -239,16 +239,6 @@ if PPC32 || PPC64
>  source "drivers/cpufreq/Kconfig.powerpc"
>  endif
>  
> -if AVR32
> -config AVR32_AT32AP_CPUFREQ
> -	bool "CPU frequency driver for AT32AP"
> -	depends on PLATFORM_AT32AP
> -	default n
> -	help
> -	  This enables the CPU frequency driver for AT32AP processors.
> -	  If in doubt, say N.
> -endif
> -

https://lkml.kernel.org/r/20180118200202.11883-1-clabbe.montjoie@gmail.com

-- 
viresh

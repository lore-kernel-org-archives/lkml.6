Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965155AbeBMPJH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:09:07 -0500
Received: from muru.com ([72.249.23.125]:56752 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965056AbeBMPJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:09:05 -0500
Date: Tue, 13 Feb 2018 07:09:00 -0800
From: Tony Lindgren <tony@atomide.com>
To: Suman Anna <s-anna@ti.com>
Cc: "J, KEERTHY" <j-keerthy@ti.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "sebastian.reichel@collabora.co.uk"
        <sebastian.reichel@collabora.co.uk>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Kristo, Tero" <t-kristo@ti.com>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>
Subject: Re: [PATCH v7 3/9] arm: omap: Move dmtimer.h out of plat-omap
Message-ID: <20180213150900.GD6364@atomide.com>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-4-git-send-email-j-keerthy@ti.com>
 <1c9f5c72-f589-d7c7-399f-ef55ecb828a0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c9f5c72-f589-d7c7-399f-ef55ecb828a0@ti.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suman Anna <s-anna@ti.com> [180213 02:07]:
> On 01/09/2018 12:23 AM, J, KEERTHY wrote:
> > The header file is currently under plat-omap directory
> > under arch/omap. Move this out to an accessible place.
> > @@ -18,7 +18,7 @@
> >   #include <linux/platform_data/hsmmc-omap.h>
> >   #include <linux/platform_data/spi-omap2-mcspi.h>
> >   #include <linux/omap-dma.h>
> > -#include <plat/dmtimer.h>
> > +#include <clocksource/dmtimer.h>
> 
> These headers are actually not needed in the first-place since we no
> longer create any non-DT timer devices. I have submitted a series to
> cleanup the presence of this header file, as part of a larger hwmod data
> cleanup series.

OK great. Keerthy, care to take a look? Seems like it
simplifies things a bit.

Regards,

Tony

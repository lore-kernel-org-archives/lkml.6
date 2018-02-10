Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeBJAEm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 19:04:42 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45332 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbeBJAEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 19:04:39 -0500
X-Google-Smtp-Source: AH8x225BO3kXcdjDdtKmSXOnsE+gIHYeOMtrjmPFGsd6NIO4i2L8IzucJHHWh0Lmgy1Rv+79rKkqsQ==
Date: Fri, 9 Feb 2018 16:04:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6/7] watchdog: meson: allow setting timeout in devicetree
Message-ID: <20180210000436.GA23513@roeck-us.net>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-7-marcus.folkesson@gmail.com>
 <20180209224849.GH19627@roeck-us.net>
 <20180209231910.GA2251@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209231910.GA2251@piout.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 12:19:10AM +0100, Alexandre Belloni wrote:
> Hi Guenter,
> 
> On 09/02/2018 at 14:48:49 -0800, Guenter Roeck wrote:
> > On Fri, Feb 09, 2018 at 08:27:23PM +0100, Marcus Folkesson wrote:
> > > watchdog_init_timeout() will allways pick timeout_param since it
> > > defaults to a valid timeout.
> > > 
> > > By following best practice described in
> > > Documentation/watchdog/watchdog-kernel-api.txt, it also
> > > let us to set timout-sec property in devicetree.
> > > 
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > 
> > Reviewed-by: Guenetr Roeck <linux@roeck-us.net>
>                   ^
> A small typo in your name
> 

Mr. Fat Fingers At Work :-)

Guenter

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755572AbeEaQBW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:01:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55281 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755525AbeEaQBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:01:19 -0400
Date: Thu, 31 May 2018 18:01:17 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>, Cristian.Birsan@microchip.com
Subject: Re: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S mux clock
Message-ID: <20180531160117.GC2727@piout.net>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
 <20180531005827.GA17203@rob-hp-laptop>
 <4f2e6e6a-df3a-b645-093c-b4467b3aa843@microchip.com>
 <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2018 09:20:57-0500, Rob Herring wrote:
> On Thu, May 31, 2018 at 5:25 AM, Codrin Ciubotariu
> <codrin.ciubotariu@microchip.com> wrote:
> > On 31.05.2018 03:58, Rob Herring wrote:
> >>
> >> On Fri, May 25, 2018 at 03:34:22PM +0300, Codrin Ciubotariu wrote:
> >>>
> >>> The I2S mux clock can be used to select the I2S input clock. The
> >>> available parents are the peripheral and the generated clocks.
> >>>
> >>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> >>> ---
> >>>   .../devicetree/bindings/clock/at91-clock.txt       | 34
> >>> ++++++++++++++++++++++
> >>>   1 file changed, 34 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> b/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> index 51c259a..1c46b3c 100644
> >>> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> @@ -90,6 +90,8 @@ Required properties:
> >>>         "atmel,sama5d2-clk-audio-pll-pmc"
> >>>                 at91 audio pll output on AUDIOPLLCLK that feeds the PMC
> >>>                 and can be used by peripheral clock or generic clock
> >>> +       "atmel,sama5d2-clk-i2s-mux":
> >>> +               at91 I2S clock source selection
> >>
> >>
> >> Is this boolean or takes some values. If latter, what are valid values?
> >
> >
> > This is the compatible string of the clock driver.
> 
> Ah, now I remember. AT91 uses fine grained clock nodes in DT. Is there
> still a plan to fix this?
> 

There is still a plan to do that, hopefully soon (I'd like to aim for
the next release or the one after).

I think this one should go in as-is so it can be fixed with all the
other one at once.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

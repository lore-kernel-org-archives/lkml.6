Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932198AbeDVOjl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 10:39:41 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51496 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756662AbeDVOjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 10:39:33 -0400
Date: Sun, 22 Apr 2018 15:39:12 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5
 SOM devices only
Message-ID: <20180422143911.GB16141@n2100.armlinux.org.uk>
References: <20180422142151.17910-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422142151.17910-1-contact@paulk.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 04:21:51PM +0200, Paul Kocialkowski wrote:
> The Solid-Run CuBox-i lower board used in the first generation of
> CuBox-i devices feature a hinged micro SD card slot, that does not have
> card-detect capability. Since the card-detect GPIO was specified in the
> common cubox-i dtsi, it is moved to each device using the 1.5 SOM and is
> thus removed from the imx6q-cubox-i dts.

This seems incorrect.

The 1.5 SOM is a relatively recent thing, and I have one of the first
Cubox-i's that were produced which is not hinged, and does not have a
1.5 SOM.  There is _no_ correlation between the 1.5 SOM and the SD
card slot.

Talking to folk at SolidRun, we're all confused about your assertions.

We're also confused about "hinged micro SD card slot" - Cubox-i's
come with either a push-push slot or a static (push-in, pull-out) slot.
(Prototypes were the latter.)

Maybe someone's modified yours?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

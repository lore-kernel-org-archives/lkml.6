Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbeCUUu4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:50:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56946 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753418AbeCUUus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:50:48 -0400
Date: Wed, 21 Mar 2018 21:50:45 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: at91: cleanup pullup on uarts
Message-ID: <20180321205045.GA19753@piout.net>
References: <20180321153552.29213-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321153552.29213-1-peda@axentia.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2018 at 16:35:49 +0100, Peter Rosin wrote:
> Hi!
> 
> I noticed a *LOT* of pointless pullups and missing pullups related
> to uart/usart pins. These patches fixes what I found.
> 
> I separated out the two changes that had pullup on neither rx nor tx,
> since there might exist some reason for that? But a pullup on tx and
> a missing pullup on rx is a sure sign of confusion, so I lumped all
> those fixes in one big patch.
> 
> One or two of the removed comments with duplicate info where wrong
> as well, i.e. the info was supposed to be duplicate but wasn't.
> 
> Cheers,
> Peter
> 
> Peter Rosin (3):
>   ARM: dts: at91: fixes uart pinctrl, set pullup on rx, clear pullup on
>     tx
>   ARM: dts: at91rm9200: pullup rx on uart0
>   ARM: dts: at91sam9260: pullup rx on usart0
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

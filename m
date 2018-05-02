Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEBHs3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:48:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39439 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbeEBHs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:48:27 -0400
Date: Wed, 2 May 2018 09:48:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: sama5d4ek: use canonical compatible for
 touchscreen
Message-ID: <20180502074825.GB18640@piout.net>
References: <20180501224833.GA151132@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501224833.GA151132@dtor-ws>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2018 15:48:33-0700, Dmitry Torokhov wrote:
> The canonical compatible string is "atmel,maxtouch", let's use it. Also,
> change the node name to be "touchscreen" rather than driver name.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/arm/boot/dts/at91-sama5d4ek.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeBBWwP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:52:15 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:53528 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeBBWwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:52:05 -0500
Date: Fri, 2 Feb 2018 23:51:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer for sama5d34ek
Message-ID: <20180202225153.GK3404@piout.net>
References: <20180124212346.3823-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124212346.3823-1-brgl@bgdev.pl>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2018 at 22:23:46 +0100, Bartosz Golaszewski wrote:
> Using compatible strings without the <manufacturer> part for at24 is
> now deprecated. Use a correct 'atmel,<model>' value.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  arch/arm/boot/dts/sama5d34ek.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

I forgot to reply but I applied all of them for 4.17, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

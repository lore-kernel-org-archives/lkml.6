Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932306AbeE2Jce (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:32:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49708 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932612AbeE2JcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:32:02 -0400
Date: Tue, 29 May 2018 11:32:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Radu Pirea <radu.pirea@microchip.com>, Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Lee Jones <lee.jones@linaro.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] mfd: at91-usart: added mfd driver for usart
Message-ID: <20180529093200.GB4793@piout.net>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-4-radu.pirea@microchip.com>
 <CAHp75VeeiFhShuMOVzuy2FjxrkfsxxzhyfAnwQNOoeaRwZ103Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeeiFhShuMOVzuy2FjxrkfsxxzhyfAnwQNOoeaRwZ103Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2018 11:00:49+0300, Andy Shevchenko wrote:
> On Fri, May 25, 2018 at 8:19 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
> > This mfd driver is just a wrapper over atmel_serial driver and
> > spi-at91-usart driver. Selection of one of the drivers is based on a
> > property from device tree. If the property is not specified, the default
> > driver is atmel_serial.
> 
> > +       depends on OF
> 
> What makes this driver OF specific?
> 
> > +       err = of_property_read_u32(np, "atmel,usart-mode", &opmode);
> 
> Check unified device property API.
> 

We don't care, this makes the driver OF specific and this is the correct
thing to do.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

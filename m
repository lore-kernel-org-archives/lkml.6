Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754461AbeEaKX3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:23:29 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33381 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbeEaKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:23:25 -0400
X-Google-Smtp-Source: ADUXVKLbPrFg4V0XcLYyLxLLgFtkaw5vc/goeT8oJ7wprORxf3oh//PHQU+hzwCM1jl43a7ErhXyaA==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Thu, 31 May 2018 13:23:15 +0300
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 2/6] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180531102315.GA5150@localhost.localdomain>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <3b05ca98a671a762013c312f8b70543402ee7556.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <20180531030129.GA16122@rob-hp-laptop>
 <20180531071717.GG13528@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531071717.GG13528@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:17:17AM +0300, Matti Vaittinen wrote:
> Hello Rob,
> 
> Thanks for the review!
> 
> On Wed, May 30, 2018 at 10:01:29PM -0500, Rob Herring wrote:
> > On Wed, May 30, 2018 at 11:42:03AM +0300, Matti Vaittinen wrote:
> > > Document devicetree bindings for ROHM BD71837 PMIC MFD.
> > > + - interrupts		: The interrupt line the device is connected to.
> > > + - interrupt-controller	: Marks the device node as an interrupt controller.
> > 
> > What sub blocks have interrupts?
> 
> The PMIC can generate interrupts from events which cause it to reset.
> Eg, irq from watchdog line change, power button pushes, reset request
> via register interface etc. I don't know any generic handling for these
> interrupts. In "normal" use-case this PMIC is powering the processor
> where driver is running and I do not see reasonable handling because
> power-reset is going to follow the irq.
> 

Oh, but when reading this I understand that the interrupt-controller
property should at least be optional.

Br,
    Matti Vaittinen

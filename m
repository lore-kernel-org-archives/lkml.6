Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbeDZTmK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:42:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34876 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbeDZTmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:42:09 -0400
Date: Thu, 26 Apr 2018 21:42:05 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roland Stigge <stigge@antcom.de>,
        Stefan Roese <sr@denx.de>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] dt-bindings: staging: remove a couple of ADC bindings
Message-ID: <20180426214205.22f1a543@windsurf>
In-Reply-To: <20180426053255.75jg5bsdu4h624jo@vireshk-i7>
References: <20180426015754.26605-1-robh@kernel.org>
        <20180426053255.75jg5bsdu4h624jo@vireshk-i7>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 26 Apr 2018 11:02:55 +0530, Viresh Kumar wrote:
> @Thomas: Do you guys use this ?
> 
> On 25-04-18, 20:57, Rob Herring wrote:
> > Remove LPC32xx and SPEAr ADC bindings in staging. They have not been
> > touched since 2012.
> > 
> > Cc: Roland Stigge <stigge@antcom.de>
> > Cc: Stefan Roese <sr@denx.de>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Move these out of staging please or they are going to be removed.
> > 
> >  .../bindings/staging/iio/adc/lpc32xx-adc.txt       | 16 -------------
> >  .../bindings/staging/iio/adc/spear-adc.txt         | 26 ----------------------
> >  2 files changed, 42 deletions(-)

We are using the spear-adc driver, which is out of staging
in ./drivers/iio/adc/spear_adc.c. So rather than removing its DT binding
entirely, it should be moved out of staging.

I'm not using the LPC32xx ADC, but the IIO driver is also out of
staging, so for the same reason, it would be strange to remove the DT
binding.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeFBGT1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbeFBGTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:19:24 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Anson Huang <Anson.Huang@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>, fabio.estevam@nxp.com,
        kernel@pengutronix.de, mark.rutland@arm.com, matteo.lisi@engicam.com,
        michael@amarulasolutions.com, mturquette@baylibre.com,
        robh+dt@kernel.org, shawnguo@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1439344955.9677.1526991935718@email.1und1.de>
Cc: linux-clk@vger.kernel.org, Linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
 <1439344955.9677.1526991935718@email.1und1.de>
Message-ID: <152792036327.225090.14543251343485084840@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
Date: Fri, 01 Jun 2018 23:19:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526JX0s003944

Quoting Stefan Wahren (2018-05-22 05:25:35)
> > +++ b/include/dt-bindings/clock/imx6ul-clock.h
> > @@ -242,20 +242,25 @@
> >  #define IMX6UL_CLK_CKO2_PODF         229
> >  #define IMX6UL_CLK_CKO2                      230
> >  #define IMX6UL_CLK_CKO                       231
> > +#define IMX6UL_CLK_GPIO1             232
> > +#define IMX6UL_CLK_GPIO2             233
> > +#define IMX6UL_CLK_GPIO3             234
> > +#define IMX6UL_CLK_GPIO4             235
> > +#define IMX6UL_CLK_GPIO5             236
> 
> this change looks like a breakage of devicetree ABI. You are changing the mean of the existing clock IDs on i.MX6ULL, which probably regress the combination of older DTBs with newer kernel.
> 

Agreed. Why can't we just tack on more numbers at the end?

> >  
> >  /* For i.MX6ULL */
> > -#define IMX6ULL_CLK_ESAI_PRED                232

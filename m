Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD6BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156862148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfA1KzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:55:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35539 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfA1KzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:55:15 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1go4ZJ-0000YF-N7; Mon, 28 Jan 2019 11:55:09 +0100
Message-ID: <1548672908.6421.1.camel@pengutronix.de>
Subject: Re: [PATCH v5 3/3] reset: imx7: Add support for i.MX8MQ IP block
 variant
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 28 Jan 2019 11:55:08 +0100
In-Reply-To: <CAHQ1cqFx3b2fTy8YbpwC0fGJYpO4BLO4FW9q-Z2Np1tVktrKpg@mail.gmail.com>
References: <20190122021043.25449-1-andrew.smirnov@gmail.com>
         <20190122021043.25449-4-andrew.smirnov@gmail.com>
         <1548240560.3904.6.camel@pengutronix.de>
         <CAHQ1cqFx3b2fTy8YbpwC0fGJYpO4BLO4FW9q-Z2Np1tVktrKpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Thu, 2019-01-24 at 16:21 -0800, Andrey Smirnov wrote:
> > Thank you, applied all three to reset/next with a small whitespace
> > alignment fix.
> > 
> 
> Thanks again for applying this stuff. If that's not too much to ask,
> would you mind creating an immutable branch, so I could start sending
> patches that depend on "dt-bindings/reset/imx8mq-reset.h" to i.MX tree
> without waiting for it to trickle down? If not, no worries, I'll wait.

Here is an immutable branch containing just the header/dt-binding patch:

  git://git.pengutronix.de/pza/linux reset/imx8mq

regards
Philipp

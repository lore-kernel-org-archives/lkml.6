Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92266ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DB320849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DB320849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeGUSIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:08:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49175 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbeGUSIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:08:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5B09A20737; Sat, 21 Jul 2018 19:15:21 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.79.60])
        by mail.bootlin.com (Postfix) with ESMTPSA id 182A7206F3;
        Sat, 21 Jul 2018 19:15:18 +0200 (CEST)
Date:   Sat, 21 Jul 2018 19:15:15 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Vitor soares <Vitor.Soares@synopsys.com>,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, psroka@cadence.com, agolec@cadence.com,
        adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com,
        alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com,
        rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com,
        robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        Joao.Pinto@synopsys.com
Subject: Re: [PATCH 0/3] Add driver for Synopsys DesignWare I3C master IP
Message-ID: <20180721191515.6b20d23b@bbrezillon>
In-Reply-To: <20180720215801.dmklhwxsgakj4exd@ninjato>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
        <20180720215801.dmklhwxsgakj4exd@ninjato>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Fri, 20 Jul 2018 23:58:01 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> On Fri, Jul 20, 2018 at 09:57:49PM +0100, Vitor soares wrote:
> > This patch series is a proposal for the I3C master driver for Synopsys IP.
> > This patch is to be applied on top of I3C subsystem RFC V6 submitted
> > by Boris Brezillon.  
> 
> Nice! More users will help the subsystem evolve.
> 
> Yet, I also think this may be a good timing for a seperate I3C mailing
> list? We can always cross-post if I2C is relevant, but I guess new I3C
> masters usually are very I3C specific. I think a seperate mailing list
> would also look good in the MAINTAINERS entry.
> 

I was waiting for the I3C framework to be merged before creating the ML
and the git repo, but if you think we should do that now I can create
them.

Regards,

Boris


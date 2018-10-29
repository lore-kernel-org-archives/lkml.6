Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77B3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7842F2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7842F2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJ2WKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:10:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35088 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeJ2WKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:10:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1605420795; Mon, 29 Oct 2018 14:21:52 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4C04C20714;
        Mon, 29 Oct 2018 14:21:51 +0100 (CET)
Date:   Mon, 29 Oct 2018 14:21:51 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Vitor soares <vitor.soares@synopsys.com>,
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
        mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com, luis.oliveira@synopsys.com,
        manuel.abreu@synopsys.com, gustavo.pimentel@synopsys.com
Subject: Re: [PATCH 0/3] Add driver for Synopsys DesignWare I3C master IP
Message-ID: <20181029142151.19f480b9@bbrezillon>
In-Reply-To: <20181029115633.GA5881@kunai>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
        <20181029115633.GA5881@kunai>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 11:56:34 +0000
Wolfram Sang <wsa@the-dreams.de> wrote:

> Boris,
> 
> > This patch series is a proposal for the I3C master driver for Synopsys IP.  
> 
> Any news on the I3C mailing list?

Nope, no news from DaveM so far. I pinged him twice (maybe my emails go
into his SPAM folder).

> It is not much yet, still I was
> wondering...
> 

The plan is to get the framework merged and then we'll have a good
argument to have the I3C ML created.

Alternatively, I could ask David Woodhouse to create a ML on infradead,
but I'd really prefer to have it on kernel.org.

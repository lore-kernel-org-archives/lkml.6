Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC36AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4682075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4682075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeKSHIw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:08:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58389 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeKSHIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:08:52 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F0A8520D23; Sun, 18 Nov 2018 21:47:32 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6135920D0D;
        Sun, 18 Nov 2018 21:47:22 +0100 (CET)
Date:   Sun, 18 Nov 2018 21:47:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.De>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: nand: spi: Add initial support for Toshiba
 TC58CVG2S0H
Message-ID: <20181118214721.1ede9fb6@xps13>
In-Reply-To: <1541665796-21092-1-git-send-email-frieder.schrempf@kontron.de>
References: <1541665796-21092-1-git-send-email-frieder.schrempf@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Schrempf,

Schrempf Frieder <frieder.schrempf@kontron.De> wrote on Thu, 8 Nov 2018
08:32:11 +0000:

> Add minimal support for the Toshiba TC58CVG2S0H SPI NAND chip.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---

With "mtd: spinand:" as prefix, applied to nand/next.

Thanks,
Miquèl

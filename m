Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC02C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C025218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAYNO4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:14:56 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50450 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAYNO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:14:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2056C207AD; Fri, 25 Jan 2019 14:14:54 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id C9D3420397;
        Fri, 25 Jan 2019 14:14:43 +0100 (CET)
Date:   Fri, 25 Jan 2019 14:14:43 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 0/2] mtd: rawnand: denali: just trivial cleanups
Message-ID: <20190125141443.1e3ec2f4@xps13>
In-Reply-To: <1548303547-21156-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548303547-21156-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu, 24 Jan
2019 13:19:05 +0900:

> Masahiro Yamada (2):
>   mtd: rawnand: denali: remove unneeded denali_reset_irq() call
>   mtd: rawnand: denali: remove unused function argument 'raw'
> 
>  drivers/mtd/nand/raw/denali.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 

Series applied to nand/next.

Thanks,
Miquèl

Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7FDC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA00320892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA00320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLGHq3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:46:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43916 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbeLGHq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:46:28 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7A5EC20834; Fri,  7 Dec 2018 08:46:26 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3843920717;
        Fri,  7 Dec 2018 08:46:26 +0100 (CET)
Date:   Fri, 7 Dec 2018 08:46:25 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 0/2] mtd: rawnand: denali: clean-up unnecessary hook
 and device reset
Message-ID: <20181207084625.2d93c769@xps13>
In-Reply-To: <1543382857-30827-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543382857-30827-1-git-send-email-yamada.masahiro@socionext.com>
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

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Wed, 28 Nov
2018 14:27:35 +0900:

> I sent this series on September,
> and Miquel replied this series was applied:
> http://patchwork.ozlabs.org/patch/967242/
> 
> But, It turned out not applied.
> 
> I rebased it and resending now.
> 
> 
> Masahiro Yamada (2):
>   mtd: rawnand: denali: remove ->dev_ready() hook
>   mtd: rawnand: denali: remove denali_reset_banks()
> 
>  drivers/mtd/nand/raw/denali.c | 52 +------------------------------------------
>  1 file changed, 1 insertion(+), 51 deletions(-)
> 

I don't know how I missed those. Sorry for that, they are now applied
on nand/next.


Thanks,
Miquèl

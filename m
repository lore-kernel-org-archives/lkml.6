Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59121C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C3F20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfAOIWc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:22:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43039 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbfAOIWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:22:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 42CEA20955; Tue, 15 Jan 2019 09:22:30 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id EF87920746;
        Tue, 15 Jan 2019 09:22:29 +0100 (CET)
Date:   Tue, 15 Jan 2019 09:22:29 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: rawnand: denali_dt: remove single anonymous clock
 support
Message-ID: <20190115092229.59e09c2d@xps13>
In-Reply-To: <1547539894-12898-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547539894-12898-1-git-send-email-yamada.masahiro@socionext.com>
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

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Tue, 15 Jan
2019 17:11:34 +0900:

> Commit 6f1fe97bec34 ("mtd: rawnand: denali_dt: add more clocks based
> on IP datasheet") introduced a more correct binding that requires
> three named clocks.
> 
> Now that all upstream DT files migrated over to it, remove the single
> anonymous clock support.

I would love to do that but I think this is against the "DT backward
compatibility rule". Anyway, IIRC it is accepted that this kind of
rule might be broken if decided per the arch-maintainer (in this
case, you I suppose). So if this is really what you want, I'll queue
it.


Thanks,
Miquèl

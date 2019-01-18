Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB983C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52C520855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfARIwe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:52:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35063 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbfARIwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:52:33 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 28405207AC; Fri, 18 Jan 2019 09:52:31 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id CE625206DC;
        Fri, 18 Jan 2019 09:52:30 +0100 (CET)
Date:   Fri, 18 Jan 2019 09:52:30 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-stable # v4 . 20" <stable@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: rawnand: denali: get ->setup_data_interface()
 working again
Message-ID: <20190118095230.5f097e9e@xps13>
In-Reply-To: <1547789438-11899-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547789438-11899-1-git-send-email-yamada.masahiro@socionext.com>
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

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Fri, 18 Jan
2019 14:30:38 +0900:

> Commit 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to
> nand_controller_ops") missed to invert the if-conditonal for denali.
> Since then, the Denali NAND driver cannnot invoke setup_data_interface.
> 
> Fixes: 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops")
> Cc: linux-stable <stable@vger.kernel.org> # v4.20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl

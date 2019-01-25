Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E73C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06022146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAYMf0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:35:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49169 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAYMfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:35:24 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7784D207B0; Fri, 25 Jan 2019 13:35:22 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2076920397;
        Fri, 25 Jan 2019 13:35:12 +0100 (CET)
Date:   Fri, 25 Jan 2019 13:35:12 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
Cc:     bbrezillon@kernel.org, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        frieder.schrempf@kontron.De, peron.clem@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: Add support for all Toshiba Memory
 products
Message-ID: <20190125133512.01018a33@xps13>
In-Reply-To: <20190116055319.2755-1-tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
References: <20190116055319.2755-1-tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshio,

Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp> wrote on Wed, 16
Jan 2019 14:53:19 +0900:

> Add device table for Toshiba Memory products.
> Also, generalize OOB layout structure and function names.
> 
> Signed-off-by: Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
> 
> ---

Applied to nand/next with the mathematical operations enclosed in
braces as discussed:

-	region->length = mtd->oobsize / 2 - 2;  
+	region->length = (mtd->oobsize / 2) - 2;  


Thanks,
Miquèl

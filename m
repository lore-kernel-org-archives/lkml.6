Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA1FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D88258DA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D88258DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030183AbeGASOf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:14:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38042 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965182AbeGASOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:14:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DB45E2079C; Sun,  1 Jul 2018 20:14:27 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1B211203B4;
        Sun,  1 Jul 2018 20:14:27 +0200 (CEST)
Date:   Sun, 1 Jul 2018 20:14:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: rawnand: fix a couple of spelling mistakes
Message-ID: <20180701201426.33d5bd90@xps13>
In-Reply-To: <93be5d64cc447fb282bcc14fed853f0c@agner.ch>
References: <20180626102629.31083-1-colin.king@canonical.com>
        <93be5d64cc447fb282bcc14fed853f0c@agner.ch>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

> On 26.06.2018 12:26, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Trival fix of two spelling mistakes in dev_err error messages:
> > "supportes" -> "supports" and "strenght" -> "strength"  
> 
> Acked-by: Stefan Agner <stefan@agner.ch>
> 
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---

Thanks for fixing this, I squashed this change with the patch adding
the driver itself.

Thanks,
Miquèl

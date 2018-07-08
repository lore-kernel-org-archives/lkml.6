Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078B8C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF44A208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF44A208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933204AbeGHVuS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:50:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38150 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932545AbeGHVuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:50:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C0B2D207DA; Sun,  8 Jul 2018 23:50:14 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 32DF3203B4;
        Sun,  8 Jul 2018 23:50:14 +0200 (CEST)
Date:   Sun, 8 Jul 2018 23:50:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next v3] mtd: spinand: fix missing unlock on error
Message-ID: <20180708235014.43648218@xps13>
In-Reply-To: <1530696627-84879-1-git-send-email-weiyongjun1@huawei.com>
References: <1530696061-76467-1-git-send-email-weiyongjun1@huawei.com>
        <1530696627-84879-1-git-send-email-weiyongjun1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Wei Yongjun <weiyongjun1@huawei.com> wrote on Wed, 4 Jul 2018 09:30:27
+0000:

> Add the missing unlock before return from function
> spinand_mtd_(read|write) in the error handling case.
> 
> Fixes: c898e0526fb6 ("mtd: nand: Add core infrastructure to support SPI NANDs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v2 -> v3: remove blank line
> v1 -> v2: using break instead of return
> ---

Merged with the original commit too.

Thanks,
Miquèl

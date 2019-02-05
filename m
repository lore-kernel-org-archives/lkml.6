Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E87C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01A0217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfBETGX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:06:23 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:50177 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfBETGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:06:23 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EF1AE200002;
        Tue,  5 Feb 2019 19:06:18 +0000 (UTC)
Date:   Tue, 5 Feb 2019 20:06:17 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <bbrezillon@kernel.org>, <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <christophe.kerello@st.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH -next] mtd: rawnand: stm32_fmc2: Make some functions
 static
Message-ID: <20190205200617.087f3e4a@xps13>
In-Reply-To: <20190130100908.19532-1-yuehaibing@huawei.com>
References: <20190130100908.19532-1-yuehaibing@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

YueHaibing <yuehaibing@huawei.com> wrote on Wed, 30 Jan 2019 18:09:08
+0800:

> Fixes the following sparse warning:
> drivers/mtd/nand/raw/stm32_fmc2_nand.c:1228:6: warning: symbol 'stm32_fmc2_read_data' was not declared. Should it be static?
> drivers/mtd/nand/raw/stm32_fmc2_nand.c:1275:6: warning: symbol 'stm32_fmc2_write_data' was not declared. Should it be static?
> drivers/mtd/nand/raw/stm32_fmc2_nand.c:1707:32: warning: symbol 'stm32_fmc2_nand_ooblayout_ops' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Merged in nand/next with the original commit.


Thanks,
Miquèl

Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A153C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34A120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfAOItO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:49:14 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43417 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbfAOItN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:49:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9930120898; Tue, 15 Jan 2019 09:49:11 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2159D20728;
        Tue, 15 Jan 2019 09:49:11 +0100 (CET)
Date:   Tue, 15 Jan 2019 09:49:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 0/2] mtd: rawnand: meson: add Amlogic NAND driver
 support
Message-ID: <20190115094911.75f4edc9@xps13>
In-Reply-To: <1544973463-59523-1-git-send-email-jianxin.pan@amlogic.com>
References: <1544973463-59523-1-git-send-email-jianxin.pan@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

Jianxin Pan <jianxin.pan@amlogic.com> wrote on Sun, 16 Dec 2018
23:17:41 +0800:

> These two patches try to add initial NAND driver support for Amlogic Meson
> SoCs, current it has been tested on GXL(p212) and AXG(s400) platform.
> 
> Changes since V6 at [8]
>  - fix bitflips checking for blank pages
>  - trace the latest commit with nand/next branch
>  - checking the return of meson_nand_op_get_dma_safe_*input/output*_buf
>  - add .detach_chip for free meson_nand.data_buf/info_buf
> 

Can you send a v9 with the build failre (object_is_on_stack pb) fixed
and the Kconfig entry updated (the Meson common clock thing) as
suggested by Martin?


Thanks,
Miquèl

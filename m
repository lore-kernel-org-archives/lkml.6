Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63B9C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04E32084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04E32084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbeJ2SjP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:39:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57519 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbeJ2SjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:39:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9E4F7207D4; Mon, 29 Oct 2018 10:51:18 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5576B20901;
        Mon, 29 Oct 2018 10:51:08 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:51:08 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michals@xilinx.com>,
        <nagasuresh12@gmail.com>
Subject: Re: [LINUX PATCH v11 0/3] Add support for Arasan NAND Flash
 controller
Message-ID: <20181029105108.562ddd21@xps13>
In-Reply-To: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote on
Tue, 25 Sep 2018 17:50:28 +0530:

> This patch series adds the basic driver support for Arasan NAND Flash controller.
> We are reinitiating the patch series by fixing the comments given by Miquel and Boris.
> Major changes are exec_op() implementation related.
> Rebased to 4.19 nand tree.
> Tested MT29F32G08ABCDBJ4.
> 
> As suggested by Boris, it also adds a new varaible called mode in
> struct nand_sdr_timings, which will give directly the sdr operating
> mode. and it is useful for some controllers, where we can configure
> direclty the operating mode instead of timings.
> 

Unless I missed something there are still comments from Boris pending?
I will wait for your v12 to give this driver another shot.

Thanks,
Miquèl

Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C24ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6B620875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6B620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388053AbeGWIam convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:30:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42936 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387943AbeGWIam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:30:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 25EF0207B3; Mon, 23 Jul 2018 09:30:49 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id AAAF120756;
        Mon, 23 Jul 2018 09:30:38 +0200 (CEST)
Date:   Mon, 23 Jul 2018 09:30:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.co" <ada@thorsis.co>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: Re: [LINUX PATCH v11 3/3] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Message-ID: <20180723093038.5f6933d3@xps13>
In-Reply-To: <MWHPR02MB2623DFB0D13FF25DECC16027AF570@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1531294612-29526-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB2623DFB0D13FF25DECC16027AF570@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Naga Sureshkumar Relli <nagasure@xilinx.com> wrote on Sun, 22 Jul 2018
07:04:41 +0000:

> Hi Miquel,
> 
> Could you please provide your review comments?
> I will address if any.

We are almost at the end of a pretty big release, I ran out of time to
do another review of your series, sorry for the delay.

Regards,
Miquèl

Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278EEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018B220675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfAORxz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:53:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33100 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfAORxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:53:55 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 18EB220797; Tue, 15 Jan 2019 18:53:53 +0100 (CET)
Received: from xps13 (unknown [77.136.198.66])
        by mail.bootlin.com (Postfix) with ESMTPSA id 310BD20712;
        Tue, 15 Jan 2019 18:53:43 +0100 (CET)
Date:   Tue, 15 Jan 2019 18:53:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <boris.brezillon@bootlin.co>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as SPI NOR co-maintainer
Message-ID: <20190115185341.3abadd3c@xps13>
In-Reply-To: <20190115165740.32450-1-tudor.ambarus@microchip.com>
References: <20190115165740.32450-1-tudor.ambarus@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

<Tudor.Ambarus@microchip.com> wrote on Tue, 15 Jan 2019 16:57:52 +0000:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> I have been reviewing and contributing to the SPI NOR subsystem
> for the last few months and I'm willing to continue doing so.
> Volunteer as a maintainer for the SPI NOR part of the MTD subsystem.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Welcome :)

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl

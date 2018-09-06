Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34020C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC26F20861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC26F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbeIGAvB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:51:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40700 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbeIGAvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:51:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B189B20789; Thu,  6 Sep 2018 22:13:55 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0937B206EE;
        Thu,  6 Sep 2018 22:13:54 +0200 (CEST)
Date:   Thu, 6 Sep 2018 22:13:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-mtd@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 1/2] mtd: nand: reorder nand manufacturer ids
Message-ID: <20180906221353.02af21b0@xps13>
In-Reply-To: <20180906084922.14845-1-marcel@ziswiler.com>
References: <20180906084922.14845-1-marcel@ziswiler.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Marcel Ziswiler <marcel@ziswiler.com> wrote on Thu,  6 Sep 2018
10:49:21 +0200:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Reorder NAND manufacturer ids for clarity.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---

Both patches applied to nand/next with subject prefix s/nand:/rawnand:/
as well as upper-case: s/nand/NAND/ and s/id/ID/ in the commit log.

Thanks,
Miquèl

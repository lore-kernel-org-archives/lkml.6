Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D68C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7F92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7F92146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeITDEn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:04:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36309 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbeITDEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:04:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6ECB920795; Wed, 19 Sep 2018 23:24:54 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id CE784203DA;
        Wed, 19 Sep 2018 23:24:53 +0200 (CEST)
Date:   Wed, 19 Sep 2018 23:24:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-mtd@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 1/2] mtd: rawnand: reorder NAND manufacturer IDs
Message-ID: <20180919232453.280dedc9@xps13>
In-Reply-To: <20180906213020.7493-1-marcel@ziswiler.com>
References: <20180906213020.7493-1-marcel@ziswiler.com>
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
23:30:19 +0200:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Reorder NAND manufacturer IDs for clarity.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---

Applied both on nand/next after rebase on top of Boris' recent cleanup.

Thanks,
Miquèl

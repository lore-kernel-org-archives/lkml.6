Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE068C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8898D20890
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8898D20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754317AbeGHLlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:41:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33848 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754227AbeGHLli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:41:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F301120737; Sun,  8 Jul 2018 13:41:35 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A4439203B4;
        Sun,  8 Jul 2018 13:41:35 +0200 (CEST)
Date:   Sun, 8 Jul 2018 13:41:33 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Sergey Larin <cerg2010cerg2010@mail.ru>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fix regressions in DoC G4 driver
Message-ID: <20180708134133.2427d488@bbrezillon>
In-Reply-To: <cover.1531045014.git.cerg2010cerg2010@mail.ru>
References: <cover.1531045014.git.cerg2010cerg2010@mail.ru>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Sun,  8 Jul 2018 14:29:22 +0300
Sergey Larin <cerg2010cerg2010@mail.ru> wrote:

> docg4 driver became broken and these patches will make it work again.

I guess you have a platform with a DoC G4 on it. If that's the case, I
might have a few changes I'd need you to test if you don't mind.

Thanks,

Boris 

> 
> Sergey Larin (2):
>   mtd: rawnand: docg4: fix NULL deref while probing
>   mtd: rawnand: docg4: specify bits_per_cell
> 
>  drivers/mtd/nand/raw/docg4.c | 2 ++
>  1 file changed, 2 insertions(+)
> 


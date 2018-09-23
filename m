Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3275FC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7623214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7623214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeIWRdM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 13:33:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40004 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeIWRdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 13:33:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E46D3207CF; Sun, 23 Sep 2018 13:35:59 +0200 (CEST)
Received: from xps13 (AToulouse-657-1-1019-69.w90-11.abo.wanadoo.fr [90.11.225.69])
        by mail.bootlin.com (Postfix) with ESMTPSA id 45E7920723;
        Sun, 23 Sep 2018 13:35:59 +0200 (CEST)
Date:   Sun, 23 Sep 2018 13:35:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] mtd: rawnand: ams-delta: Cleanups and
 optimizations
Message-ID: <20180923133557.08107d3b@xps13>
In-Reply-To: <20180919225255.31175-1-jmkrzyszt@gmail.com>
References: <20180820213904.13475-1-jmkrzyszt@gmail.com>
        <20180919225255.31175-1-jmkrzyszt@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Thu, 20 Sep 2018
00:52:52 +0200:

> This series consist of possibly ready to apply patches extracted from
> a former one titled "mtd: rawnand:  ams-delta: Use GPIO API for data I/O".
> Remaining patches implementing conversion of data I/O to GPIO have been
> postponed until gpiolib is optimized to ensure sufficient performance.
> 
> 
> Janusz Krzysztofik (3):
>       mtd: rawnand: ams-delta: show parent device in sysfs
>       mtd: rawnand: ams-delta: Use private structure
>       mtd: rawnand: ams-delta: Set port direction when needed
> 
> 

Series applied on nand/next.

Thanks,
Miquèl

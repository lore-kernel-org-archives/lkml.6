Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FEBC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0992075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0992075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeIELQl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:16:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33267 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbeIELQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:16:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9499320756; Wed,  5 Sep 2018 08:47:59 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 557A5203DC;
        Wed,  5 Sep 2018 08:47:59 +0200 (CEST)
Date:   Wed, 5 Sep 2018 08:47:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] mtd: rawnand: ams-delta: Cleanups and
 optimizations
Message-ID: <20180905084757.432e7c19@xps13>
In-Reply-To: <20180820213904.13475-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
        <20180820213904.13475-1-jmkrzyszt@gmail.com>
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

Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Mon, 20 Aug 2018
23:39:01 +0200:

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

Patch 2/3 does not apply on nand/next. Indeed the driver does not look
the same as in the diff. I don't see any changes on my side that could
explain this so perhaps you could rebase on top of 4.19-rc2 (or
nand/next, as you wish) and resend the series?

Thanks,
Miquèl

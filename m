Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203C9C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47F5206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47F5206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeJEVhx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:37:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47554 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbeJEVhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:37:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E890120DCD; Fri,  5 Oct 2018 16:38:50 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9F60D207F3;
        Fri,  5 Oct 2018 16:38:40 +0200 (CEST)
Date:   Fri, 5 Oct 2018 16:38:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][mtd-next] mtd: rawnand: fix spelling mistake
 "card_registred" -> "card_registered"
Message-ID: <20181005163841.21f3b3ce@xps13>
In-Reply-To: <20180927152431.6031-1-colin.king@canonical.com>
References: <20180927152431.6031-1-colin.king@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Colin King <colin.king@canonical.com> wrote on Thu, 27 Sep 2018
16:24:31 +0100:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake struct field name, rename it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to nand/next with the subject prefix changed to be

        mtd: rawnand: r852:

Thanks,
Miquèl

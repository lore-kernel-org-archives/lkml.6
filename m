Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA1AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639332082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639332082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeIECYH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:24:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54672 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbeIECYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:24:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B1DF620731; Tue,  4 Sep 2018 23:57:03 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3654C206A6;
        Tue,  4 Sep 2018 23:56:53 +0200 (CEST)
Date:   Tue, 4 Sep 2018 23:56:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: nand: denali: use SPDX-License-Identifier and fix
 license mismatch
Message-ID: <20180904235651.12708e91@xps13>
In-Reply-To: <1534735596-10876-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534735596-10876-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Mon, 20 Aug
2018 12:26:36 +0900:

> Use SPDX-License-Identifier instead of the license boilerplates.
> 
> This conversion makes it easier for us to scan the license, then
> I notice license mismatch problems.
> 
> The license blocks in denali* indicate GPL-2.0 "only", while the
> MODULE_LICENSE in denali.c and denali_dt.c is GPL-2.0 "or later"
> as explained in include/linux/module.h as follows:
> 
>   "GPL"                           [GNU Public License v2 or later]
>   "GPL v2"                        [GNU Public License v2]
> 
> I fixed the MODULE_LICENSE tags, assuming the license blocks are
> the authors' intention.
> 
> Also, add missing MODULE_DESCRIPTION/AUTHOR to denali.c
> 
> While I am touching the license things, I added my credit to denali.c
> because this driver was largely re-written by me in 2017.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to nand/next with subject prefix s/nand/rawnand/.

Thanks,
Miquèl

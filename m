Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DFBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D312086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D312086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934392AbeFRMOp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:14:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34799 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933859AbeFRMOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:14:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04B6120703; Mon, 18 Jun 2018 14:14:43 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5575D20862;
        Mon, 18 Jun 2018 14:14:31 +0200 (CEST)
Date:   Mon, 18 Jun 2018 14:14:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@sigma-star.at>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] mtd: rawnand: denali_dt: use dev as a shorthand of
 &pdev->dev
Message-ID: <20180618141431.68ca434e@xps13>
In-Reply-To: <20180618135410.5a480ccd@xps13>
References: <1528799515-1356-1-git-send-email-yamada.masahiro@socionext.com>
        <20180618135410.5a480ccd@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Mon, 18 Jun 2018 13:54:10 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:

> Hi Masahiro,
> 
> On Tue, 12 Jun 2018 19:31:54 +0900, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> 
> > Add 'dev' as a shorthand before adding more code that takes a
> > pointer to struce device.  
> 
> s/struce/a struct/?
> 
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>  
> 
> With this fixed:
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

I missed the two next versions with Boris/Richard reviews, forget about
this one.

Sorry for the inconvenience,
Miquèl


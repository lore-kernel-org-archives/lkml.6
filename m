Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1135C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7607C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7607C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937528AbeFSJA0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:00:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37143 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937343AbeFSJAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:00:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DBD052079D; Tue, 19 Jun 2018 11:00:20 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9DFEF20799;
        Tue, 19 Jun 2018 11:00:20 +0200 (CEST)
Date:   Tue, 19 Jun 2018 11:00:20 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC PATCH v2 5/6] mtd: rawnand: micron: add
 ONFI_FEATURE_ON_DIE_ECC to supported features
Message-ID: <20180619110020.40ea964a@xps13>
In-Reply-To: <20180619074056.420d5560@bbrezillon>
References: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
        <20180619053125.16792-6-chris.packham@alliedtelesis.co.nz>
        <20180619074056.420d5560@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 19 Jun 2018 17:31:24 +1200
> Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> 
> > Add ONFI_FEATURE_ON_DIE_ECC to the set/get features list for Micron
> > NAND flash.
> >  
> 
> Fixes: 789157e41a06 ("mtd: rawnand: allow vendors to declare (un)supported features")
> Cc: <stable@vger.kernel.org>
> 
> No need to send a new version, I'll add that when queuing the patch.
> 
> Miquel, if you're okay, I'm gonna take this patch in the mtd/fixes branch
> and let you deal with other patches in this series.
> 
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl

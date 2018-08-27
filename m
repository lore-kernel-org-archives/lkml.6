Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D02C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F78208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F78208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbeH0THd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:07:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46193 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeH0THd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:07:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AE0C22072C; Mon, 27 Aug 2018 17:20:29 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5B42420618;
        Mon, 27 Aug 2018 17:20:29 +0200 (CEST)
Date:   Mon, 27 Aug 2018 17:20:28 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     liuxiang <liuxiang_1999@126.com>
Cc:     "Liu Xiang" <liu.xiang6@zte.com.cn>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, han.xu@nxp.com,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at,
        "Yogesh Narayan Gaur" <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH] mtd: spi-nor: fsl-quadspi: fix read error for flash
 size larger than 16MB
Message-ID: <20180827172028.0e6e6e41@bbrezillon>
In-Reply-To: <3571f5ca.c32c.1657be858d1.Coremail.liuxiang_1999@126.com>
References: <1534583663-2842-1-git-send-email-liu.xiang6@zte.com.cn>
        <20180827100613.78823993@bbrezillon>
        <3571f5ca.c32c.1657be858d1.Coremail.liuxiang_1999@126.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 23:02:29 +0800 (CST)
liuxiang  <liuxiang_1999@126.com> wrote:

> Fixes:e46ecda764dc37f9fc6279d95ea2c007daef1a71("mtd: spi-nor: Add Freescale QuadSPI driver")

12 digits should be enough for the commit-id.

> Cc: stable@vger.kernel.org
> 
> Should I send a V2 patch that adds these above？

Yes please.

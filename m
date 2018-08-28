Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69084C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F9A2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F9A2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeH1SJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:09:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48767 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH1SJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:09:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CB6C1207EB; Tue, 28 Aug 2018 16:17:46 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7A869206A6;
        Tue, 28 Aug 2018 16:17:36 +0200 (CEST)
Date:   Tue, 28 Aug 2018 16:17:35 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     "Liu Xiang" <liuxiang_1999@126.com>
Cc:     "Liu Xiang" <liu.xiang6@zte.com.cn>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        han.xu@nxp.com, marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at
Subject: Re: [PATCH v2] mtd: spi-nor: fsl-quadspi: fix read error for flash
 size  larger than 16MB
Message-ID: <20180828161735.55cccaa8@bbrezillon>
In-Reply-To: <749634d5.bb6a.16580e444f2.Coremail.liuxiang_1999@126.com>
References: <1535462476-3540-1-git-send-email-liu.xiang6@zte.com.cn>
        <20180828152305.18df57e2@bbrezillon>
        <749634d5.bb6a.16580e444f2.Coremail.liuxiang_1999@126.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 22:16:08 +0800 (CST)
"Liu Xiang" <liuxiang_1999@126.com> wrote:

> Thanks for your suggestion. Should I send another patch?

Yes please.

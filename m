Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A283AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A31820843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A31820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbeIYV2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:28:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45614 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729332AbeIYV2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:28:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 771092075C; Tue, 25 Sep 2018 17:20:44 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4369820711;
        Tue, 25 Sep 2018 17:20:44 +0200 (CEST)
Date:   Tue, 25 Sep 2018 17:20:44 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH 0/2] spi: Add Macronix controller driver
Message-ID: <20180925172044.6513402f@bbrezillon>
In-Reply-To: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
References: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Mon, 17 Sep 2018 15:16:17 +0800
masonccyang@mxic.com.tw wrote:

> From: Mason Yang <masonccyang@mxic.com.tw>
> 
> Hi Mark and Trent,
> 
> I patched spi-mxic.c and add the run time PM function.

BTW, you forgot to add v2 in the subject prefix (can be done by passing
-vX to git format-patch, where X is the version number).

Regards,

Boris

> 
> thanks & best regards,
> Mason
> 
> Mason Yang (2):
>   spi: Add MXIC controller driver
>   dt-binding: spi: Document Macronix controller bindings
> 
>  Documentation/devicetree/bindings/spi/spi-mxic.txt |  34 ++
>  drivers/spi/Kconfig                                |   6 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-mxic.c                             | 674 +++++++++++++++++++++
>  4 files changed, 715 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
>  create mode 100644 drivers/spi/spi-mxic.c
> 


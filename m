Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E909C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF5B2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547912590;
	bh=Ml4Mkp8nCS2/c0cy7Su8HYrB29V+abYd6Obw4Icabyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=GvbGj2QzqEDLYwQrwhTPwehYGKzLjyT2VmbTgRgsSsULHhrG8u2yjeZUUrk3mb/pe
	 0ylFFWsDhlxe0ja8cEhCJZhiIuyad8l81ZSKw3JDUYerG6e2VwvV+Q00wJ3RYTx90f
	 JXqWWWkEJwkqIHgZs2DDxT8HAaM8Vu4hgfnxviZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfASPnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 10:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbfASPnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 10:43:08 -0500
Received: from localhost.localdomain (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 153072084C;
        Sat, 19 Jan 2019 15:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547912587;
        bh=Ml4Mkp8nCS2/c0cy7Su8HYrB29V+abYd6Obw4Icabyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=UA0vWOEAo34kgKohSzHFcTreZPxnQ3WJ33q/R21HO6Q0dxiuBOHWqBOZUkzo08pvf
         1WtBcpxKik88tOWfq8rnmr+IZkz8FrDazvxQBLJrTYCjIlEZ8IRnhsMACm6z8q04ab
         P+HWnwBhWwfGBAjw41lyhgInPkxPYb5f9EF4xzvw=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2, 1/3] dt-bindings: mtd: mtk-quadspi: update bindings for MT7629 SoC
Date:   Sat, 19 Jan 2019 16:43:01 +0100
Message-Id: <20190119154301.3800-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 4a09a91e5efd3759d28ae4708a7bcef11bee4416
In-Reply-To: <74d710ed89fd505a49bce53b51f6cb489e313dbb.1547538621.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 02:12:03 UTC, Ryder Lee wrote:
> This updates bindings for the MT7629 SPI-NOR controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris

Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E72C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0545A2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547912580;
	bh=QHGE4X/SMd6Gk4Y/RvZDd4ym48B2gZlOPy5H8LSkrZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=KgwPF0CSwCtM0kdAIL3brzBoS2WPPNR+1ZxRv1HoDLX+LKcZBeyY/Y99+1Ab9kbWz
	 tT7vHI4CX8irz4pLMGGE89k0ShBIXyrJjpTIa7UJ3j/XT3Vq9+Vfihi9KBT97nw53w
	 jyYxuxgNnv+irsrO6iw8kZseHWbshYIXJgrRoppI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfASPm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 10:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbfASPm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 10:42:57 -0500
Received: from localhost.localdomain (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4F22084C;
        Sat, 19 Jan 2019 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547912577;
        bh=QHGE4X/SMd6Gk4Y/RvZDd4ym48B2gZlOPy5H8LSkrZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=nuGs/whpR0XQMW1BDtUnXgLCLdopjdOSsZvpTLzAJRws/E61dprNRpVkO3okJI39Q
         NOxfOEMYSsCY2/rvFtfgE7q00eZK9VostqJYcIGvpN5FaBejE15UtbanK1qx83Zlrd
         Nx7bcXrF47lq//B+95x2/ZUADbkTEYgvP0xe0+cY=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org, Guochun Mao <guochun.mao@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2, 2/3] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ to spi_nor_hwcaps mask
Date:   Sat, 19 Jan 2019 16:42:48 +0100
Message-Id: <20190119154248.3733-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 9cca9b3e55989f8b227d05897877648d67910a6d
In-Reply-To: <2afa18c0c898259fc244f15844c5319f71e811df.1547538621.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 02:12:04 UTC, Ryder Lee wrote:
> From: Guochun Mao <guochun.mao@mediatek.com>
> 
> SNOR_HWCAPS_READ should be supported by this controller, so add this
> flag to spi_nor_hwcaps mask.
> 
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris

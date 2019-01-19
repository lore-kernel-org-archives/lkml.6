Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D0C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174712084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547912566;
	bh=MpgK9cBUruzeZTwcYfI3H8rhHdYJuAKQXgAkZLKfQOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=qi6WJryBzvZaVefjHtnEk5lBUbdW61hBbQzA4sc6lPeBTvavrx2dbV5ew2tLYu7O5
	 l3htW/HP9MT6MLn4j5tDthZL86p/SAm2OttTipb0+ff+Ww1pe4Nmn62TPmu/oPVOFI
	 bZqiD671Q+G/p1ghODt2uE3SJHWruMDwRX37ajCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfASPmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 10:42:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbfASPmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 10:42:44 -0500
Received: from localhost.localdomain (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3BCF2087E;
        Sat, 19 Jan 2019 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547912564;
        bh=MpgK9cBUruzeZTwcYfI3H8rhHdYJuAKQXgAkZLKfQOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=XF0b0TBqg6I8+PmMnnzTHN5RluGF+/LN0oIRci38cz3mBlcIQkjpTuvb5p2NqxGUS
         rPbLwlUh2ngeEg8KE8NidBc0WiwyqLUymH9DdCRFBIkXLuxFPpL6S4o0cz7qg1vItf
         eCbU3/SNpXnMOyQCWVtuT4wXxytMVWMu8snO8Ks0=
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
Subject: Re: [v2,3/3] mtd: spi-nor: mtk-quadspi: rename config to a common one
Date:   Sat, 19 Jan 2019 16:42:35 +0100
Message-Id: <20190119154235.3665-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 356dd9ce2361ba5ba74eeff227fb6ab6d46e128c
In-Reply-To: <761c9a0a482795dbc48949e982ab46987b737e08.1547538621.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 02:12:05 UTC, Ryder Lee wrote:
> The quadspi is a generic communication interface which could be shared
> with other MediaTek SoCs. Hence rename it to a common one.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris

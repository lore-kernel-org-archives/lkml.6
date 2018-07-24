Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B46ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B742C20881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JivEzRpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B742C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbeGXNfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388172AbeGXNfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:35:06 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A8EC205F4;
        Tue, 24 Jul 2018 12:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532435331;
        bh=mm0DKTve8DsKBwFD0MUFChgBSPkqTRdZv25R/wlLjRY=;
        h=From:To:Cc:Subject:Date:From;
        b=JivEzRpcdbWjlPVKZc8chKgGt27t/HwLGP0gFNydb11jJfMMOTnzyCV2vaf/TzBRD
         /YUIHe/FV0y0OTvAfqYtlqT5c3dL5vQtbblxTUsJGD59XrP9UFvwM/RGDTfX6Pbxqk
         PKsNKEAhfA7ctFTdCubV6hvuGJNTUIYS6B6IaCVc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Vineet Gupta <vineet.gupta@synopsys.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARC: Add Ofer Levi as plat-eznps maintainer
Date:   Tue, 24 Jul 2018 15:28:42 +0300
Message-Id: <20180724122842.2895-1-leon@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c79f306a936a..6be664ed0527 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5444,6 +5444,7 @@ F:	drivers/iommu/exynos-iommu.c

 EZchip NPS platform support
 M:	Vineet Gupta <vgupta@synopsys.com>
+M:	Ofer Levi <oferle@mellanox.com>
 S:	Supported
 F:	arch/arc/plat-eznps
 F:	arch/arc/boot/dts/eznps.dts
--
2.14.4


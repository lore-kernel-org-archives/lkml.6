Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E80AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C577C20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="arDRmDjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C577C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeGXOfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbeGXOfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:35:44 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343D420856;
        Tue, 24 Jul 2018 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532438954;
        bh=5D5glRklGQ/K+VfXksgPA3JT7BhAneYo3vV5NZHDNbk=;
        h=From:To:Cc:Subject:Date:From;
        b=arDRmDjcU4bS6E3klmoRLp45cK/V4aTU581xWm84b5N7iaXjF5rX9ZP2Ko76+RWw6
         /R5fzw8o0T9Mi+HhsGrRjFTnDceZ94E/6LyaKrd2LSRX8VabLNkbfeRZmvDB4/MQDl
         djKjyNj8JqVcts+8pxM2AwJlHZE0MwZv8BQOjZ+M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ARC <linux-snps-arc@lists.infradead.org>,
        Meir Lichtinger <meirl@mellanox.com>
Subject: [PATCH RESEND] ARC: Add Ofer Levi as plat-eznps maintainer
Date:   Tue, 24 Jul 2018 16:29:06 +0300
Message-Id: <20180724132906.9671-1-leon@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 Resend with proper Vineet's email
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


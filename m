Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6243ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0B2206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAnThuET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0B2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeGQRPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729668AbeGQRPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:15:52 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC3520693;
        Tue, 17 Jul 2018 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531845742;
        bh=Zml4KVOe5bTGCTkVboe9/q4w7IdWSKZS6pVcASBEnQk=;
        h=From:To:Cc:Subject:Date:From;
        b=GAnThuETVFoazopoAmYnDwKZRpZMz0TD81Ww9rB866sCTIxu6SqxJhHBcdEc1juOc
         qgHOTJHnOeEQ0yudsIrYZOyBhNCv06RHGJPPIhasHF8prpL1sdUU1racupC0egJ/Yf
         5qJksgiESQwnbLHUnU8+tXTeBtj+kvy7f3vl0n1g=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Bordug <vbordug@ru.mvista.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] MAINTAINERS: Drop inactive Vitaly Bordug's email
Date:   Tue, 17 Jul 2018 18:41:54 +0200
Message-Id: <20180717164154.6577-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Vitaly Bordug's email bounces ("ru.mvista.com: Name or service not
known") and there was no activity (ack, review, sign) since 2009.

Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcefb7a19f58..c84c8085d5b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5850,7 +5850,6 @@ F:	include/linux/fsl/
 
 FREESCALE SOC FS_ENET DRIVER
 M:	Pantelis Antoniou <pantelis.antoniou@gmail.com>
-M:	Vitaly Bordug <vbordug@ru.mvista.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.14.1


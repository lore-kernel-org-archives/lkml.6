Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623D5C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D4E20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="SVEHHSxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfBBGZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:25:01 -0500
Received: from tomli.me ([153.92.126.73]:45116 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfBBGZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:25:01 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 28ea7a8a;
        Sat, 2 Feb 2019 06:18:18 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:77ab)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Feb 2019 06:18:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=Gmm5seB3OZi3kf409TzIneYpUn7FFA/oBWAnHfi8Z/o=; b=SVEHHSxkI3eRM4pTqrepvVSEnZunWAerrXdIEmEwfxE+oMHCUTsBNbmfddhu8uQifmMe/CyYGnrR61wA3tVWiggHUKH4+oYyb0pXXzycC9V03QrJV6aelyth6ztQI/Q8hWvZKmW6QIXFUR+CTf+/bDQb2hNfpLrrR4mSHeo8ZyhlK1W0I4V0OEzTb7Ip+nSGwvVVwBthqayAetjSG7fwTUTKzn7mkTqL1VkjQ8H9ZHlRDZcNilFJ//WBxIQYpKdz6asWHsY+zvxk/nd4wmeq9GgqhzFl36k2WXW+BqwwoLmb5+/kRejK7lLOcloVbVY8pQt0VADAxFVeKeR96wmTVg==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 8/8] MAINTAINERS: sm712fb: list myself as one maintainer.
Date:   Sat,  2 Feb 2019 14:16:48 +0800
Message-Id: <20190202061648.30374-9-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
References: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have working on the sm712fb driver for a while and have some familiarity
with this hardware, I'll be helping working on and testing problems of this
driver, so add myself to the MAINTAINERS file.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..d62adb2caa87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13838,6 +13838,7 @@ F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c
 
 SILICON MOTION SM712 FRAME BUFFER DRIVER
+M:	Tom Li <tomli@tomli.me>
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 M:	Teddy Wang <teddy.wang@siliconmotion.com>
 M:	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
-- 
2.20.1


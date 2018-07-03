Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4685C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75BC21C66
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75BC21C66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934216AbeGCRFW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:05:22 -0400
Received: from anholt.net ([50.246.234.109]:41070 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934110AbeGCRFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:05:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D621D10A1860;
        Tue,  3 Jul 2018 10:05:19 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ny26aK_Mk13M; Tue,  3 Jul 2018 10:05:18 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6955D10A0EEB;
        Tue,  3 Jul 2018 10:05:16 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 7370B2FE463C; Tue,  3 Jul 2018 10:05:15 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 3/4] drm/v3d: Add missing v3d documentation structure.
Date:   Tue,  3 Jul 2018 10:05:14 -0700
Message-Id: <20180703170515.6298-3-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180703170515.6298-1-eric@anholt.net>
References: <20180703170515.6298-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was a failure of "git add" on my part -- we already referenced
the doc from drivers.rst.

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 Documentation/gpu/v3d.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/gpu/v3d.rst

diff --git a/Documentation/gpu/v3d.rst b/Documentation/gpu/v3d.rst
new file mode 100644
index 000000000000..543f7fbf526e
--- /dev/null
+++ b/Documentation/gpu/v3d.rst
@@ -0,0 +1,28 @@
+=====================================
+ drm/v3d Broadcom V3D Graphics Driver
+=====================================
+
+.. kernel-doc:: drivers/gpu/drm/v3d/v3d_drv.c
+   :doc: Broadcom V3D Graphics Driver
+
+GPU buffer object (BO) management
+---------------------------------
+
+.. kernel-doc:: drivers/gpu/drm/v3d/v3d_bo.c
+   :doc: V3D GEM BO management support
+
+Address space management
+===========================================
+.. kernel-doc:: drivers/gpu/drm/v3d/v3d_mmu.c
+   :doc: Broadcom V3D MMU
+
+GPU Scheduling
+===========================================
+.. kernel-doc:: drivers/gpu/drm/v3d/v3d_sched.c
+   :doc: Broadcom V3D scheduling
+
+Interrupts
+--------------
+
+.. kernel-doc:: drivers/gpu/drm/v3d/v3d_irq.c
+   :doc: Interrupt management for the V3D engine
-- 
2.18.0


Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74453ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4099920825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4099920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeKIBxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:53:12 -0500
Received: from anholt.net ([50.246.234.109]:33378 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeKIBxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:53:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 657E810A1336;
        Thu,  8 Nov 2018 08:16:58 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id lg3LwTwwLwgq; Thu,  8 Nov 2018 08:16:57 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6EC6310A130F;
        Thu,  8 Nov 2018 08:16:55 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 092E22FE1B8E; Thu,  8 Nov 2018 08:16:54 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/4] drm/v3d: Fix whitespace inconsistency in the header.
Date:   Thu,  8 Nov 2018 08:16:51 -0800
Message-Id: <20181108161654.19888-2-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108161654.19888-1-eric@anholt.net>
References: <20181108161654.19888-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 include/uapi/drm/v3d_drm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index f446656d00b1..b1e5de076b0f 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -66,7 +66,7 @@ struct drm_v3d_submit_cl {
 	 */
 	__u32 bcl_start;
 
-	 /** End address of the BCL (first byte after the BCL) */
+	/** End address of the BCL (first byte after the BCL) */
 	__u32 bcl_end;
 
 	/* Offset of the render command list.
@@ -82,7 +82,7 @@ struct drm_v3d_submit_cl {
 	 */
 	__u32 rcl_start;
 
-	 /** End address of the RCL (first byte after the RCL) */
+	/** End address of the RCL (first byte after the RCL) */
 	__u32 rcl_end;
 
 	/** An optional sync object to wait on before starting the BCL. */
-- 
2.19.1


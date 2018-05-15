Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeEOUit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:38:49 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60515 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752506AbeEOUir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:38:47 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, "David Airlie" <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philippe Cornu <philippe.cornu@st.com>
Subject: [PATCH] drm/bridge: checkpatch strict minor updates
Date: Tue, 15 May 2018 22:37:36 +0200
Message-ID: <20180515203736.9224-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.139]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor fixes detected with "scripts/checkpatch.pl --strict"

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
Detected when merging "drm: clarify adjusted_mode documentation for bridges"

 include/drm/drm_bridge.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 9917651a7fdd..70131ab57e8f 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -97,7 +97,7 @@ struct drm_bridge_funcs {
 	/**
 	 * @mode_fixup:
 	 *
-	 * This callback is used to validate and adjust a mode. The paramater
+	 * This callback is used to validate and adjust a mode. The parameter
 	 * mode is the display mode that should be fed to the next element in
 	 * the display chain, either the final &drm_connector or the next
 	 * &drm_bridge. The parameter adjusted_mode is the input mode the bridge
@@ -301,15 +301,15 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		      struct drm_bridge *previous);
 
 bool drm_bridge_mode_fixup(struct drm_bridge *bridge,
-			const struct drm_display_mode *mode,
-			struct drm_display_mode *adjusted_mode);
+			   const struct drm_display_mode *mode,
+			   struct drm_display_mode *adjusted_mode);
 enum drm_mode_status drm_bridge_mode_valid(struct drm_bridge *bridge,
 					   const struct drm_display_mode *mode);
 void drm_bridge_disable(struct drm_bridge *bridge);
 void drm_bridge_post_disable(struct drm_bridge *bridge);
 void drm_bridge_mode_set(struct drm_bridge *bridge,
-			struct drm_display_mode *mode,
-			struct drm_display_mode *adjusted_mode);
+			 struct drm_display_mode *mode,
+			 struct drm_display_mode *adjusted_mode);
 void drm_bridge_pre_enable(struct drm_bridge *bridge);
 void drm_bridge_enable(struct drm_bridge *bridge);
 
-- 
2.15.1

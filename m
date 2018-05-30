Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeE3J57 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:57:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59742 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeE3J55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:57:57 -0400
From: Colin King <colin.king@canonical.com>
To: Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gvt: fix spelling mistake: "resseting" -> "resetting"
Date: Wed, 30 May 2018 10:57:49 +0100
Message-Id: <20180530095749.11113-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in gvt_dbg_core message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/gvt/vgpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 2e0a02a80fe4..7b856c9b4e07 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -502,7 +502,7 @@ void intel_gvt_reset_vgpu_locked(struct intel_vgpu *vgpu, bool dmlr,
 	unsigned int resetting_eng = dmlr ? ALL_ENGINES : engine_mask;
 
 	gvt_dbg_core("------------------------------------------\n");
-	gvt_dbg_core("resseting vgpu%d, dmlr %d, engine_mask %08x\n",
+	gvt_dbg_core("resetting vgpu%d, dmlr %d, engine_mask %08x\n",
 		     vgpu->id, dmlr, engine_mask);
 
 	vgpu->resetting_eng = resetting_eng;
-- 
2.17.0

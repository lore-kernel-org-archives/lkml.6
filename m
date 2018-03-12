Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeCLLoH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:44:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56927 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeCLLoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:44:04 -0400
From: Colin King <colin.king@canonical.com>
To: Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][drm-next] drm/i915/gvt: fix spelling mistake: "destoried" -> "destroyed"
Date: Mon, 12 Mar 2018 12:43:58 +0100
Message-Id: <20180312114358.24456-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in gvt_err error message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 0a100a288e6d..8eb76becd676 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -2046,7 +2046,7 @@ static void intel_vgpu_destroy_all_ppgtt_mm(struct intel_vgpu *vgpu)
 	}
 
 	if (GEM_WARN_ON(!list_empty(&vgpu->gtt.ppgtt_mm_list_head)))
-		gvt_err("vgpu ppgtt mm is not fully destoried\n");
+		gvt_err("vgpu ppgtt mm is not fully destroyed\n");
 
 	if (GEM_WARN_ON(!radix_tree_empty(&vgpu->gtt.spt_tree))) {
 		gvt_err("Why we still has spt not freed?\n");
-- 
2.15.1

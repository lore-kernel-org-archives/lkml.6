Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934671AbeEIJTQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:19:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51960 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934332AbeEIJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:19:13 -0400
From: Colin King <colin.king@canonical.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/dp: fix spelling mistake: "seqeuncer" -> "sequencer"
Date: Wed,  9 May 2018 10:19:08 +0100
Message-Id: <20180509091908.13804-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in WARN warning message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index dde92e4af5d3..914389f67458 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -513,7 +513,7 @@ vlv_power_sequencer_kick(struct intel_dp *intel_dp)
 	uint32_t DP;
 
 	if (WARN(I915_READ(intel_dp->output_reg) & DP_PORT_EN,
-		 "skipping pipe %c power seqeuncer kick due to port %c being active\n",
+		 "skipping pipe %c power sequencer kick due to port %c being active\n",
 		 pipe_name(pipe), port_name(intel_dig_port->base.port)))
 		return;
 
-- 
2.17.0

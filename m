Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeCHXYb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:24:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751182AbeCHXY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:24:29 -0500
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] drm/i915: Remove unused DP_LINK_CHECK_TIMEOUT
Date: Thu,  8 Mar 2018 18:24:15 -0500
Message-Id: <20180308232421.14049-2-lyude@redhat.com>
In-Reply-To: <20180308232421.14049-1-lyude@redhat.com>
References: <20180308232421.14049-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/intel_dp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index 9a4a51e79fa1..4dd1b2287dd6 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -43,7 +43,6 @@
 #include <drm/i915_drm.h>
 #include "i915_drv.h"
 
-#define DP_LINK_CHECK_TIMEOUT	(10 * 1000)
 #define DP_DPRX_ESI_LEN 14
 
 /* Compliance test status bits  */
-- 
2.14.3

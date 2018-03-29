Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeC2Hkd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:40:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:4220 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeC2Hkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:40:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="41684883"
Date: Thu, 29 Mar 2018 15:39:36 +0800
From: kbuild test robot <lkp@intel.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: kbuild-all@01.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [RFC PATCH] drm/xen-front: display_mode_valid() can be static
Message-ID: <20180329073936.GA84198@lkp-sb04>
References: <1522219661-26827-3-git-send-email-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522219661-26827-3-git-send-email-andr2000@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: d7f404c8b4b6 ("drm/xen-front: Add support for Xen PV display frontend")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 xen_drm_front_kms.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index 545049d..bd676be 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -273,7 +273,7 @@ static void display_update(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
+static enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
 		const struct drm_display_mode *mode)
 {
 	struct xen_drm_front_drm_pipeline *pipeline =

Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B3DC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203D12146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203D12146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeLAGiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:38:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:46972 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAGiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:38:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 11:27:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="279426270"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2018 11:27:44 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS)
Subject: [PATCH RFC 03/15] drm/nouveau: replace **** with a hug
Date:   Fri, 30 Nov 2018 11:27:12 -0800
Message-Id: <20181130192737.15053-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to comply with the CoC, replace **** with a hug.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c        | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
index 9cc10e438b3d..55a0060881ea 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -446,7 +446,7 @@ init_ram_restrict(struct nvbios_init *init)
 {
 	/* This appears to be the behaviour of the VBIOS parser, and *is*
 	 * important to cache the NV_PEXTDEV_BOOT0 on later chipsets to
-	 * avoid fucking up the memory controller (somehow) by reading it
+	 * avoid hugging up the memory controller (somehow) by reading it
 	 * on every INIT_RAM_RESTRICT_ZM_GROUP opcode.
 	 *
 	 * Preserving the non-caching behaviour on earlier chipsets just
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
index 3737bd27f74e..ee364c71cc2e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
@@ -46,7 +46,7 @@
 #define NV_PPWR_INTR_EN_SET_SUBINTR                                  0x00000800
 #define NV_PPWR_INTR_EN_SET_WATCHDOG                                 0x00000002
 #define NV_PPWR_INTR_EN_CLR                                              0x0014
-#define NV_PPWR_INTR_EN_CLR_MASK                    /* fuck i hate envyas */ -1
+#define NV_PPWR_INTR_EN_CLR_MASK                    /* hug i hate envyas */ -1
 #define NV_PPWR_INTR_ROUTE                                               0x001c
 #define NV_PPWR_TIMER_LOW                                                0x002c
 #define NV_PPWR_WATCHDOG_TIME                                            0x0034
-- 
2.19.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeEaFvP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:51:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:55268 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbeEaFvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:51:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,462,1520924400";
   d="scan'208";a="233383241"
From: "Hean-Loong, Ong" <hean.loong.ong@intel.com>
To: Rob Herring <robh+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        hean.loong.ong@intel.com, yves.vandervennet@intel.com,
        chin.liang.see@intel.com, Ong@vger.kernel.org
Subject: [PATCH 2/3] ARM:socfpga-defconfig Intel FPGA Video and Image Processing Suite
Date: Thu, 31 May 2018 13:50:50 +0800
Message-Id: <1527745851-3339-3-git-send-email-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527745851-3339-1-git-send-email-hean.loong.ong@intel.com>
References: <1527745851-3339-1-git-send-email-hean.loong.ong@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ong Hean Loong <hean.loong.ong@intel.com>

Intel FPGA Video and Image Processing Suite Frame Buffer II
driver config for Arria 10 devkit and its variants

Signed-off-by: Ong, Hean Loong <hean.loong.ong@intel.com>
---
 arch/arm/configs/socfpga_defconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 2620ce7..d7deee8 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -111,6 +111,11 @@ CONFIG_MFD_ALTERA_A10SR=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_DRM=m
+CONFIG_DRM_IVIP=m
+CONFIG_DRM_IVIP_OF=m
+CONFIG_FB=y
+CONFIG_FB_SIMPLE=y
 CONFIG_USB=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC2=y
-- 
1.7.1

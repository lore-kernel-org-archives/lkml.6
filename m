Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754031AbeEaGCR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:02:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:31759 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754005AbeEaGCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:02:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,462,1520924400";
   d="scan'208";a="60036429"
From: "Hean-Loong, Ong" <hean.loong.ong@intel.com>
To: Rob Herring <robh+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        hean.loong.ong@intel.com, yves.vandervennet@intel.com,
        chin.liang.see@intel.com, Ong@vger.kernel.org
Subject: [PATCHv8 2/3] ARM:socfpga-defconfig Intel FPGA Video and Image Processing Suite
Date: Thu, 31 May 2018 14:01:53 +0800
Message-Id: <1527746514-3861-3-git-send-email-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527746514-3861-1-git-send-email-hean.loong.ong@intel.com>
References: <1527746514-3861-1-git-send-email-hean.loong.ong@intel.com>
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
index 371fca4..21d8d2b 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -112,6 +112,11 @@ CONFIG_MFD_ALTERA_A10SR=y
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

Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5294C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5A62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfBKGJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:09:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:57411 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKGJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:09:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2019 22:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="115217560"
Received: from helong-vb.png.intel.com ([10.226.243.17])
  by orsmga006.jf.intel.com with ESMTP; 10 Feb 2019 22:09:41 -0800
From:   "Hean-Loong, Ong" <hean.loong.ong@intel.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rienk de Jong <rienk.dejong@quest-innovations.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, hean.loong.ong@intel.com,
        yves.vandervennet@intel.com, chin.liang.see@intel.com,
        Ong@vger.kernel.org
Subject: [PATCHv12 2/3] ARM:socfpga-defconfig Intel FPGA Video and Image Processing Suite
Date:   Mon, 11 Feb 2019 14:09:25 +0800
Message-Id: <20190211060926.3433-3-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211060926.3433-1-hean.loong.ong@intel.com>
References: <20190211060926.3433-1-hean.loong.ong@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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


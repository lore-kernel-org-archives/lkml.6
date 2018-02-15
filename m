Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032702AbeBODXF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 22:23:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:24050 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032563AbeBODXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 22:23:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,515,1511856000";
   d="scan'208";a="201243352"
From: "Ooi, Joyce" <joyce.ooi@intel.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Dinh Nguyen <dinh.nguyen@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        Yves Vandervennet <yves.vandervennet@intel.com>,
        Ong Hean Loong <hean.loong.ong@intel.com>
Subject: [PATCH] arm64: defconfig: enable CONFIG_LEDS_TRIGGER_TIMER
Date: Thu, 15 Feb 2018 11:20:28 +0800
Message-Id: <1518664828-30883-1-git-send-email-joyce.ooi@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable LED timer trigger for ARM64 to allow LEDs to be controlled via
sysfs.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 arch/arm64/configs/defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..b728742 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -471,6 +471,8 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
 CONFIG_LEDS_SYSCON=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
-- 
1.7.1

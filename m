Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3004C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DE1214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DE1214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIYELW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:11:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:5955 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeIYELV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:11:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 15:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,299,1534834800"; 
   d="scan'208";a="75595419"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.132])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2018 15:07:00 -0700
From:   thor.thayer@linux.intel.com
To:     lee.jones@linaro.org, peppe.cavallaro@st.com, dinguyen@kernel.org,
        linux@armlinux.org.uk, alexandre.torgue@st.com,
        joabreu@synopsys.com
Cc:     thor.thayer@linux.intel.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org, arnd@arndb.de, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
Date:   Mon, 24 Sep 2018 17:09:04 -0500
Message-Id: <1537826946-18942-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
References: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add System Manager driver by default for SOCFPGA ARM32 platforms.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm/configs/socfpga_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 371fca4e1ab7..c510a32f9f0d 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -109,6 +109,7 @@ CONFIG_SENSORS_LTC2978_REGULATOR=y
 CONFIG_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_MFD_ALTERA_A10SR=y
+CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.7.4


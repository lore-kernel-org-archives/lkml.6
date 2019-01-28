Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D46BC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AA721738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfA1WMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:12:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:37504 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfA1WMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:12:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 14:12:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="111810512"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2019 14:12:03 -0800
From:   thor.thayer@linux.intel.com
To:     lee.jones@linaro.org, arnd@arndb.de, dinguyen@kernel.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com
Cc:     davem@davemloft.net, mcoquelin.stm32@gmail.com,
        mchehab+samsung@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, olof@lixom.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv3 3/6] ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
Date:   Mon, 28 Jan 2019 16:14:12 -0600
Message-Id: <1548713655-25940-4-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548713655-25940-1-git-send-email-thor.thayer@linux.intel.com>
References: <1548713655-25940-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add System Manager driver by default for SOCFPGA ARM32 platforms.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2-3 No change
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


Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DB52063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfANPnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:43:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:43400 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbfANPnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:43:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 07:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,478,1539673200"; 
   d="scan'208";a="311688622"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2019 07:43:32 -0800
From:   richard.gong@linux.intel.com
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        atull@kernel.org, dinguyen@kernel.org, todd.riffel@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1] arm64: defconfig: enable Intel Stratix10 service layer driver
Date:   Mon, 14 Jan 2019 09:52:17 -0600
Message-Id: <1547481137-25844-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Intel Stratix10 service layer driver was added with commit 7ca5ce896524
("firmware: add Intel Stratix10 service layer driver").

Intel Stratix10 service layer provides kernel APIs for drivers to request
access to the secure features. Such features include FPGA programming,
remote status update, read and write the secure registers.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ef443c..42bc993 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -706,6 +706,7 @@ CONFIG_QCOM_QFPROM=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_UNIPHIER_EFUSE=y
 CONFIG_MESON_EFUSE=m
+CONFIG_INTEL_STRATIX10_SERVICE=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_EXT2_FS=y
-- 
2.7.4


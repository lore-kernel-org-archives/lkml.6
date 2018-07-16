Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E35AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E811208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E811208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emc.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeGPMDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:03:35 -0400
Received: from emcscan.emc.com.tw ([192.72.220.5]:64187 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeGPMDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:03:35 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 08:03:34 EDT
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with SMTP; 16 Jul 2018 19:26:27 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(124511:0:AUTH_RELAY)
        (envelope-from <kt.liao@emc.com.tw>); Mon, 16 Jul 2018 19:26:38 +0800 (CST)
Received: from 192.168.33.46
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(124028:1:AUTH_LOGIN)
        (envelope-from <kt.liao@emc.com.tw>); Mon, 16 Jul 2018 19:26:35 +0800 (CST)
From:   KT Liao <kt.liao@emc.com.tw>
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, ulrik.debie-os@e2big.org
Cc:     anantshende@gmail.com, kt.liao@emc.com.tw
Subject: [PATCH] Input: elan_i2c - Add antoher ACPI ID for Lenovo Ideapad 330-15AST
Date:   Mon, 16 Jul 2018 19:26:29 +0800
Message-Id: <1531740389-4040-1-git-send-email-kt.liao@emc.com.tw>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ELAN0622 in ACPI mapping table to support Ideapad 330-15AST ELAN touchpad

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Reported-by: Anant Shende <anantshende@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 2690a4b..f7e75f0 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1344,6 +1344,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN060B", 0 },
 	{ "ELAN060C", 0 },
 	{ "ELAN0611", 0 },
+	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };
-- 
2.7.4


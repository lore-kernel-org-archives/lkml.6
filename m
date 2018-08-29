Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE88C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D53820644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D53820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeH2UqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:46:08 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19328 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2UqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:46:08 -0400
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="16859068"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Aug 2018 09:48:22 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Wed, 29 Aug 2018 09:48:17 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ARM: configs: at91: Add I2S driver to sama5
Date:   Wed, 29 Aug 2018 19:47:54 +0300
Message-ID: <20180829164755.4690-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2S CONFIG_SND_ATMEL_SOC_I2S to sama5_defconfig.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 2080025556b5..b6d73055a854 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -167,6 +167,7 @@ CONFIG_SND_ATMEL_SOC_WM8904=y
 # CONFIG_HID_GENERIC is not set
 CONFIG_SND_ATMEL_SOC_PDMIC=y
 CONFIG_SND_ATMEL_SOC_TSE850_PCM5142=m
+CONFIG_SND_ATMEL_SOC_I2S=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.17.1


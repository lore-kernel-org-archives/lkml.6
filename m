Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55CFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BC12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BC12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeH2MLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:11:01 -0400
Received: from mout.perfora.net ([74.208.4.196]:57845 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:11:00 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LgFj0-1fXytH3dPY-00neGw; Wed, 29 Aug 2018 10:15:12 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 27/31] ARM: tegra: colibri_t20: add compatibility comment
Date:   Wed, 29 Aug 2018 10:14:03 +0200
Message-Id: <20180829081407.11304-28-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:73VeWZX66aU48Z7OL405q31gPlIb8iZLhditIYvdqp+dKtaJ/CT
 p8PKOUQD9qO4+PZhaLfkZ2z9TiYW04s5YeFDM1ZMK6LptbtoRWJzXw/udFU7mobeHk4HupF
 Vauf3XtUSaOnG1zW3ok24pEKEe/H723aiNSxe9FfAGPFa7ZoRE2gy4e63AU+QVWslBiQ3kb
 PZZUHkY680bV6jn42oZ0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:beZAO3hBBwM=:2ecvJcpqHx6YldnY8Ps6N2
 JolUwpVnNx0XFc2+a1uBqDi/JiNlQdnF96wvNgH79vH0Io9WUwH25BqZHp5X25OTe9pWtavDU
 0QPygR2CY6FbbgjVU9t37Eyg08LcudBT9PHB5IIGCYWXzGcxqu34wvIwHH/xqp794tvXv8FPv
 JhhBf8o5v5M0uhKTV3OVOlYjfjmTNZyIoUp2rSVnfKc96QHOMVXAOE2yLCS8vP5jzmQ/F116J
 E3vp8Q5YEPUoAx2Ux+wnndyunAjMRV7jxDUqZ9kRDmztxC190ihZeIeyUWshe4AgQUuRark5I
 YM+IqcXIMkvW5ahFDf9L6bWlKqjk9oajGv8eVBKE2w09G6W9KJIB59czmhdJppLsHA3ICo88o
 JsqOrVqQCSjTBcxDack3BzoQNtD6EEk9Nos4ICux2gVYXlOwnjuvzDVvChSSKtMBqzoabwW/S
 ejVH8oUeGdYV5hy1LaKfOCEG2O3DXEtjqeKygWKvmwxb6x/bbdULqxqkFsQKLgVdd3MCvO4IV
 fasTyyM0KzsJRU1NalSmVcYoKz1lsuz1jimKvy2fSZGSPB3GEf8m5eN2olXJUUGE3Cndupdqi
 ppYcYoYge8wziM7NIF83xV2O06168Cy/jQK1N5HQ+J85Vke3ueJYVbCXugRiCPcTcwi0xvM1f
 ++mVXtlL4egCmRUamOSGIIeaYiV8lkzjHo5E8dpGX61Q2C5sf7KpJTK8rRuB4PQLnsyA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add compatibility comment.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 057147565b1e..1204aa9e1d57 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -1,6 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "tegra20.dtsi"
 
+/*
+ * Toradex Colibri T20 Module Device Tree
+ * Compatible for Revisions Colibri T20 256MB V1.1B, V1.2A;
+ * Colibri T20 256MB IT V1.2A; Colibri T20 512MB V1.1C, V1.2A;
+ * Colibri T20 512MB IT V1.2A
+ */
 / {
 	model = "Toradex Colibri T20 256/512 MB";
 	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
-- 
2.14.4


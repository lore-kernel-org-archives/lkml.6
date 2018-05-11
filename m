Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeEKT2B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:28:01 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:10632 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeEKT0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:26:52 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <ssantosh@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [linux-next PATCH 4/4] ARM: keystone: k2g: enable micrel and dp83867 phys
Date: Fri, 11 May 2018 15:29:12 -0400
Message-ID: <1526066952-5230-5-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
References: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable micrel and dp83867 phys for K2G Boards in keystone_defconfig
to support Network driver on these boards (K2G ICE and GP EVM).

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 2536c23..85cf2fc 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -235,3 +235,5 @@ CONFIG_INPUT_GPIO_DECODER=m
 CONFIG_GPIO_PCA953X=m
 CONFIG_LEDS_TRIGGER_ACTIVITY=y
 CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_MICREL_PHY=y
+CONFIG_DP83867_PHY=y
-- 
1.9.1

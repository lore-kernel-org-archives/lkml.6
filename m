Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424273AbeE1LNc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424260AbeE1LN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:13:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 207/272] ARM: dts: keystone-k2e-clocks: Fix missing unit address separator
Date: Mon, 28 May 2018 12:04:00 +0200
Message-Id: <20180528100257.903473469@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suman Anna <s-anna@ti.com>

[ Upstream commit 5a3a03905a433216f517babd0a343ae7265e9ca1 ]

Commit 95d8b41c765b ("ARM: dts: keystone-k2e-clocks: Add missing unit
name to clock nodes that have regs") fixed the unit names on various
clock nodes but missed out adding the unit address separator on the
clkhyperlink0 clock node. Fix the same.

Fixes: 95d8b41c765b ("ARM: dts: keystone-k2e-clocks: Add missing unit name to clock nodes that have regs")
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
@@ -42,7 +42,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkhyperlink0: clkhyperlink02350030 {
+	clkhyperlink0: clkhyperlink0@2350030 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk12>;

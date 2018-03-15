Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeCOHR3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:17:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40657 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeCOHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:17:28 -0400
X-Google-Smtp-Source: AG47ELunlU/H9KqBXA9Y0lME2QV4YpevxK1UI3Jc0NE3MxgqbhGYI6yZJvv9Vh+LvX8K7TdzlVoi2g==
From: Jacob Chen <jacob-chen@iotwrt.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        heiko@sntech.de, Jacob Chen <jacob-chen@iotwrt.com>
Subject: [PATCH] ARM: dts: rockchip: fix uart4 pin-num for rk3288
Date: Thu, 15 Mar 2018 15:17:14 +0800
Message-Id: <20180315071714.11589-1-jacob-chen@iotwrt.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to TRM, uart4 tx/rx should be 14/15

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ed05f3d77358..40327c764385 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1938,16 +1938,16 @@
 
 		uart4 {
 			uart4_xfer: uart4-xfer {
-				rockchip,pins = <5 12 3 &pcfg_pull_up>,
-						<5 13 3 &pcfg_pull_none>;
+				rockchip,pins = <5 15 3 &pcfg_pull_up>,
+						<5 14 3 &pcfg_pull_none>;
 			};
 
 			uart4_cts: uart4-cts {
-				rockchip,pins = <5 14 3 &pcfg_pull_up>;
+				rockchip,pins = <5 12 3 &pcfg_pull_up>;
 			};
 
 			uart4_rts: uart4-rts {
-				rockchip,pins = <5 15 3 &pcfg_pull_none>;
+				rockchip,pins = <5 13 3 &pcfg_pull_none>;
 			};
 		};
 
-- 
2.16.1

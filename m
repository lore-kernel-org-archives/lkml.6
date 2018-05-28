Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424668AbeE1LQN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424637AbeE1LQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:16:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 262/272] ARM: dts: at91: tse850: use the correct compatible for the eeprom
Date: Mon, 28 May 2018 12:04:55 +0200
Message-Id: <20180528100302.166661866@linuxfoundation.org>
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

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 7981190fb5dd710dea08c2613cee3d05e795ca5e ]

The used part does contain an eeprom compatible with an Atmel 24c02
chip and it is from NXP, but it is not called 24c02. It's actually a
se97b chip. Adjust the compatible accordingly.

Fixes: 21dd0ece34c2 ("ARM: dts: at91: add devicetree for the Axentia TSE-850")
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/at91-tse850-3.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/at91-tse850-3.dts
@@ -246,7 +246,7 @@
 	};
 
 	eeprom@50 {
-		compatible = "nxp,24c02", "atmel,24c02";
+		compatible = "nxp,se97b", "atmel,24c02";
 		reg = <0x50>;
 		pagesize = <16>;
 	};

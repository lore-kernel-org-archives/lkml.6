Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeC1CHL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:07:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41126 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbeC1CHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:07:05 -0400
X-Google-Smtp-Source: AIpwx4/lPsIgThtk85FwPQR69/rTIDsMrNABe0cdikvFl5NQq8+EuSPptWQ+KxYMDZ+MfP69fiid/A==
From: Rob Herring <robh@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] microblaze: dts: replace 'linux,stdout-path' with 'stdout-path'
Date: Tue, 27 Mar 2018 21:07:00 -0500
Message-Id: <20180328020700.17050-4-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180328020700.17050-1-robh@kernel.org>
References: <20180328020700.17050-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'linux,stdout-path' has been deprecated for some time in favor of
'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
Search and replace the one occurrence with 'stdout-path'.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: devicetree@vger.kernel.org
---
 arch/microblaze/boot/dts/system.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/boot/dts/system.dts b/arch/microblaze/boot/dts/system.dts
index b620da23febb..8a420c6702eb 100644
--- a/arch/microblaze/boot/dts/system.dts
+++ b/arch/microblaze/boot/dts/system.dts
@@ -44,7 +44,7 @@
 	} ;
 	chosen {
 		bootargs = "console=ttyUL0,115200 highres=on";
-		linux,stdout-path = "/plb@0/serial@84000000";
+		stdout-path = "/plb@0/serial@84000000";
 	} ;
 	cpus {
 		#address-cells = <1>;
-- 
2.14.1

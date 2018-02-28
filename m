Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932764AbeB1SQ3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:16:29 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37101 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbeB1SQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:16:25 -0500
X-Google-Smtp-Source: AH8x225urjg05CN2W496yvid2y22MZ6Dt479CTxzYjaSKiLIWJlM5PI4Cf+TwieNReh4a1ANd44CIw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 09/10] MAINTAINERS: Add reviewer for ACTIONS platforms
Date: Wed, 28 Feb 2018 23:44:31 +0530
Message-Id: <20180228181432.26847-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228181432.26847-1-manivannan.sadhasivam@linaro.org>
References: <20180228181432.26847-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I'll be working on improving support for ACTIONS platforms, adding
myself as the reviewer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76eadae9..640dabc4c311 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1117,6 +1117,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 
 ARM/ACTIONS SEMI ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
+R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 N:	owl
-- 
2.14.1

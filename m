Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeBQUql (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:46:41 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42720 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbeBQUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:46:08 -0500
X-Google-Smtp-Source: AH8x226xvhye69odl4Vl6r8cGx9jCaymGuPSGWBGxZj5bILMR3n//rXfbl72XRoE5cCQLBRCn3ONzw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/10] MAINTAINERS: Add reviewer for ACTIONS platforms
Date: Sun, 18 Feb 2018 02:14:32 +0530
Message-Id: <20180217204433.3095-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
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
index e6c26cb47d02..96b8b6531196 100644
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeC1Ryu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:54:50 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43731 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753400AbeC1Ryq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:54:46 -0400
X-Google-Smtp-Source: AIpwx4/K5rrmcez5pQjZMTTMijYbfdIE0svlgAh0gkOy3m8BUB+CIx32BioEgKMp8sKNwLmKhekXhA==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 8/9] MAINTAINERS: Add reviewer for ACTIONS platforms
Date: Wed, 28 Mar 2018 23:17:02 +0530
Message-Id: <20180328174703.19778-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
References: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
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

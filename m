Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeCWJSA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:18:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39333 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751668AbeCWJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:35 -0400
X-UUID: 85b9cd7b8eaa4afe9a72139cfed2aa36-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 15/16] MAINTAINERS: update entry for ARM/Mediatek RTC DRIVER
Date: Fri, 23 Mar 2018 17:15:12 +0800
Message-ID: <abadf0686094826b241944ee5563996de9a0f41a.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-4.067500-8.000000-10
X-TMASE-MatchedRID: x6uIgBUWMEwxFdXyW/P+XbiMC5wdwKqdK2i9pofGVSuY5ISV79wbr2b6
        PphVtfZgRAjjCBWd1tV63xQjyx+HXtOYsB74R7ecdARARTk4h599LQinZ4QefCP/VFuTOXUT3n8
        eBZjGmUzkwjHXXC/4I66NVEWSRWybUsAHQn5GEzDRpjwMXIGP7K6HZQqIz+9cwoeDtmp32d04Fa
        0M94SCv/g5LDH7EcAUuHuaTWKtdCtLm6vl+Utdqjfj9WnQo0h58OyccFNBL2TKhETi2//sjuP9C
        b59K8ACZrS+A8PszW+YV38c4KFOjw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.067500-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add new files for new dt-bindings and a globally visible header file.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d3c33d7..1c13f29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1626,9 +1626,11 @@ M:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 F:	Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
 F:	drivers/rtc/rtc-mt6397.c
 F:	drivers/rtc/rtc-mt7622.c
+F:	include/linux/rtc/mt6397.h
 
 ARM/Mediatek SoC support
 M:	Matthias Brugger <matthias.bgg@gmail.com>
-- 
2.7.4

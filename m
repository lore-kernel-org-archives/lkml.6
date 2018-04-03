Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754933AbeDCHQY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:16:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39455 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754884AbeDCHQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:16:16 -0400
X-UUID: e6a926d6a9dc4ee790068ac1f52a90e0-20180403
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 7/7] MAINTAINERS: add an entry for MediaTek Bluetooth driver
Date: Tue, 3 Apr 2018 15:15:57 +0800
Message-ID: <549b949ea99b5a9e53ddb163c4f9e84e5f9bde9d.1522736996.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1522736996.git.sean.wang@mediatek.com>
References: <cover.1522736996.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23760.005
X-TM-AS-Result: No-3.302600-8.000000-10
X-TMASE-MatchedRID: x6uIgBUWMEwxFdXyW/P+XSbMb0f5D0uqTI0NfY99MMnfUZT83lbkEJpx
        JPA5ZIe+kzWMi48/G7J63xQjyx+HXtOYsB74R7ecdARARTk4h599LQinZ4QefCP/VFuTOXUT3n8
        eBZjGmUzkwjHXXC/4I8ZW5ai5WKlysywZoLB59eG4a8TSvDMNY6ysmCeElXqVbKp70Jkg4KcTsJ
        DHHjrwIp6uK6W8QsGXxAHmJOZEaprCPSySJD1IS1SMEKvosDo38OyccFNBL2TKhETi2//sjuP9C
        b59K8ACZrS+A8PszW/U9h9N881NSQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.302600-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23760.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add an entry for the MediaTek Bluetooth driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4923621..ea2cd52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8832,6 +8832,14 @@ F:	include/uapi/linux/meye.h
 F:	include/uapi/linux/ivtv*
 F:	include/uapi/linux/uvcvideo.h
 
+MEDIATEK BLUETOOTH DRIVER
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	linux-bluetooth@vger.kernel.org
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
+F:	drivers/bluetooth/hci_mediatek.c
+
 MEDIATEK CIR DRIVER
 M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
-- 
2.7.4

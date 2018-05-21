Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeEUN3S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:29:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38260 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeEUN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:29:10 -0400
X-Google-Smtp-Source: AB8JxZp7RoyhYYAwTPh9ozdvmW0ktXYCZN30RCAIX8VlN4/Z4EOI9vG7qm1GLEqB/5xowxsvrAZ18Q==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org, michal.vokac@ysoft.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net
Subject: [PATCH net-next 1/7] net: dsa: qca8k: Add QCA8334 binding documentation
Date: Mon, 21 May 2018 15:28:07 +0200
Message-Id: <1526909293-56377-2-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
References: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 Documentation/devicetree/bindings/net/dsa/qca8k.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.txt b/Documentation/devicetree/bindings/net/dsa/qca8k.txt
index 9c67ee4..3d73cd0 100644
--- a/Documentation/devicetree/bindings/net/dsa/qca8k.txt
+++ b/Documentation/devicetree/bindings/net/dsa/qca8k.txt
@@ -2,7 +2,10 @@
 
 Required properties:
 
-- compatible: should be "qca,qca8337"
+- compatible: should be one of:
+    "qca,qca8334"
+    "qca,qca8337"
+
 - #size-cells: must be 0
 - #address-cells: must be 1
 
-- 
2.1.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934457AbeCGWns (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:43:48 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:41142 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934399AbeCGWnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:43:46 -0500
From: Brad Mouring <brad.mouring@ni.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Michael Grzeschik" <m.grzeschik@pengutronix.de>
CC: Mark Rutland <mark.rutland@arm.com>, <netdev@vger.kernel.org>,
        "Julia Cartwright" <julia@ni.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Brad Mouring <brad.mouring@ni.com>
Subject: [PATCH 2/2] Documentation: macb: Document phy-handle optional binding
Date: Wed, 7 Mar 2018 16:42:57 -0600
Message-ID: <20180307224257.1959-2-brad.mouring@ni.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307224257.1959-1-brad.mouring@ni.com>
References: <20180307224257.1959-1-brad.mouring@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
---
 Documentation/devicetree/bindings/net/macb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
index 27966ae741e0..457d5ae16f23 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -29,6 +29,7 @@ Optional properties for PHY child node:
 - reset-gpios : Should specify the gpio for phy reset
 - magic-packet : If present, indicates that the hardware supports waking
   up via magic packet.
+- phy-handle : see ethernet.txt file in the same directory
 
 Examples:
 
-- 
2.16.2

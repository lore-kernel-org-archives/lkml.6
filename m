Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FA3C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895A020868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895A020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeLAB6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:58:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56137 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeLAB5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:57:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 654A220CFA; Fri, 30 Nov 2018 15:48:15 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id B812A20D0D;
        Fri, 30 Nov 2018 15:47:46 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 6/8] MAINTAINERS: phy: add entry for Armada 3700 COMPHY driver
Date:   Fri, 30 Nov 2018 15:47:41 +0100
Message-Id: <20181130144743.675-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130144743.675-1-miquel.raynal@bootlin.com>
References: <20181130144743.675-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as Armada 3700 COMPHY driver/bindings maintainer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..a1d6457cccb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8864,6 +8864,12 @@ F:	drivers/gpu/drm/armada/
 F:	include/uapi/drm/armada_drm.h
 F:	Documentation/devicetree/bindings/display/armada/
 
+MARVELL ARMADA 3700 COMPHY DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+F:	Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
+
 MARVELL CRYPTO DRIVER
 M:	Boris Brezillon <boris.brezillon@bootlin.com>
 M:	Arnaud Ebalard <arno@natisbad.org>
-- 
2.19.1


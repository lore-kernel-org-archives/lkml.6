Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeEBISF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:18:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53270 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeEBISD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:18:03 -0400
X-Google-Smtp-Source: AB8JxZpZ/gXBwa3ZWH9UhvpMJbAWYTeazHNhbmgbtrIlkfCc9xglIlV8EOhhE1KouSbxPCrRjW3wrQ==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, SZ Lin <sz.lin@moxa.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH] dt-bindings: Add vendor prefix for Avnet, Inc.
Date: Wed,  2 May 2018 10:17:57 +0200
Message-Id: <d860eb7551e343fa59b77fd3e144a633186a8378.1525249073.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Avnet, Inc. is one of the world's largest distributors of electronic
components and embedded solutions." - Wikipedia.org

Website: www.avnet.com

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b5f978a4cac6..60272bbdbe09 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -47,6 +47,7 @@ auvidea Auvidea GmbH
 avago	Avago Technologies
 avia	avia semiconductor
 avic	Shanghai AVIC Optoelectronics Co., Ltd.
+avnet	Avnet, Inc.
 axentia	Axentia Technologies AB
 axis	Axis Communications AB
 bananapi BIPAI KEJI LIMITED
-- 
2.17.0

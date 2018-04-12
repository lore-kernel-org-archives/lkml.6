Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeDLOew (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:34:52 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:43820 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbeDLOeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:34:50 -0400
X-Auth-Info: epUNs6RB9llPvqROMYL/CIyS3MyVEQw7Zk8osrVY97Q=
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] doc: Add vendor prefix for Kaohsiung
Date: Thu, 12 Apr 2018 16:34:01 +0200
Message-Id: <20180412143401.6433-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'kao' entry has been added to vendor-prefixes.txt to indicate
products from Kaohsiung Opto-Electronics Inc.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8ff7eadc8bef..f995a876d2cc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -184,6 +184,7 @@ khadas	Khadas
 kiebackpeter    Kieback & Peter GmbH
 kinetic Kinetic Technologies
 kingnovel	Kingnovel Technology Co., Ltd.
+koe	Kaohsiung Opto-Electronics Inc.
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
 lacie	LaCie
-- 
2.11.0

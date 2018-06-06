Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="v++G3kR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6894160555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeFFMtw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:49:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52295 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeFFMtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:49:50 -0400
X-Google-Smtp-Source: ADUXVKIu1/BU3LiocpvQTC++4jUVBUUgVIevQQVmKZeA8KtEi0Nr5ZtgXwyeNFGcc9XZtyGrkM4x9w==
From: Michal Simek <monstr@monstr.eu>
To: devicetree@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, SZ Lin <sz.lin@moxa.com>
Subject: [PATCH] dt-bindings: Add bitmain vendor prefix
Date: Wed,  6 Jun 2018 14:49:48 +0200
Message-Id: <20173c07cc538544c9e6780a8ef558b97a3fe2cb.1528289384.git.monstr@monstr.eu>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bitmain (https://www.bitmain.com) is a vendor of cryptocurrency
hardware.

Signed-off-by: Michal Simek <monstr@monstr.eu>
---

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 36003832c2a8..ddb52511a583 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -51,6 +51,7 @@ axentia	Axentia Technologies AB
 axis	Axis Communications AB
 bananapi BIPAI KEJI LIMITED
 bhf	Beckhoff Automation GmbH & Co. KG
+bitmain	Bitmain Technologies
 boe	BOE Technology Group Co., Ltd.
 bosch	Bosch Sensortec GmbH
 boundary	Boundary Devices Inc.
-- 
1.9.1

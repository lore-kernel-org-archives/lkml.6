Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbeE1SDh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:03:37 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39900 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932616AbeE1SCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:02:00 -0400
X-Google-Smtp-Source: ADUXVKJMzqVqsTI3pNlAn92pvnv+aAh1EXIwt2qNQjlLvxpRBCpx2CupNmcRYZQ1pMYXdbOaZwWXKg==
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 2/6] Documentation: DT: Add optional 'timeout-sec' property for sp805
Date: Mon, 28 May 2018 11:01:33 -0700
Message-Id: <1527530497-10392-3-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SP805 binding document to add optional 'timeout-sec'
devicetree property

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
index 0fa3629..bee6f1f 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
+++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
@@ -19,6 +19,8 @@ Required properties:
 
 Optional properties:
 - interrupts:  Should specify WDT interrupt number
+- timeout-sec: Should specify default WDT timeout in seconds. If unset, the
+               default timeout is determined by the driver
 
 Example:
 	watchdog@66090000 {
-- 
2.1.4

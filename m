Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934953AbeEWUcf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:32:35 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35538 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934917AbeEWUca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:32:30 -0400
X-Google-Smtp-Source: AB8JxZq6UEzLkhapbuYyIgAKcCxzrFG1inTNE/qG9oadNXO21F2f2G2XtiLpMUv//irXufn/imK0Cg==
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
Subject: [PATCH v2 2/6] Documentation: DT: Add optional 'timeout-sec' property for sp805
Date: Wed, 23 May 2018 13:32:03 -0700
Message-Id: <1527107527-8093-3-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
References: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SP805 binding document to add optional 'timeout-sec'
devicetree property

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
index de93a4d..9cd7470 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
+++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
@@ -18,6 +18,8 @@ Required properties:
 
 Optional properties:
 - interrupts : Should specify WDT interrupt number.
+timeout-sec : Should specify default WDT timeout in seconds. If unset, the
+              default timeout in the driver is 30 seconds
 
 Example:
 	watchdog@66090000 {
-- 
2.1.4

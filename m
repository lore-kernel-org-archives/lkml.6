Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeEVSrk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:47:40 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36764 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeEVSrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:47:36 -0400
X-Google-Smtp-Source: AB8JxZoxSijW8DETFtA2Nhhv4EbWSi6sSnHZ2TvL6/N/LFWdOJMn2oG6rfmf1igsQ/3r5pOxM7g4eA==
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec' property for sp805
Date: Tue, 22 May 2018 11:47:16 -0700
Message-Id: <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SP805 binding document to add optional 'timeout-sec'
devicetree property

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
index edc4f0e..f898a86 100644
--- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
@@ -19,6 +19,8 @@ Required properties:
 
 Optional properties:
 - interrupts : Should specify WDT interrupt number.
+- timeout-sec : Should specify default WDT timeout in seconds. If unset, the
+                default timeout is 30 seconds
 
 Examples:
 
-- 
2.1.4

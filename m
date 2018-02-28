Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932728AbeB1TB3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:01:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43381 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeB1TB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:01:28 -0500
Date: Wed, 28 Feb 2018 11:01:04 -0800
From: tip-bot for Geert Uytterhoeven <tipbot@zytor.com>
Message-ID: <tip-7998a4ecc61fbef5547afd379b8953b526709dd2@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, marc.zyngier@arm.com,
        tglx@linutronix.de, horms+renesas@verge.net.au, mark.rutland@arm.com,
        geert+renesas@glider.be, robh+dt@kernel.org, jason@lakedaemon.net,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        marc.zyngier@arm.com, horms+renesas@verge.net.au, mark.rutland@arm.com,
        jason@lakedaemon.net, robh+dt@kernel.org, geert+renesas@glider.be,
        mingo@kernel.org
In-Reply-To: <1519658712-22910-1-git-send-email-geert+renesas@glider.be>
References: <1519658712-22910-1-git-send-email-geert+renesas@glider.be>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] dt-bindings/irqchip/renesas-irqc: Document R-Car
 M3-N support
Git-Commit-ID: 7998a4ecc61fbef5547afd379b8953b526709dd2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7998a4ecc61fbef5547afd379b8953b526709dd2
Gitweb:     https://git.kernel.org/tip/7998a4ecc61fbef5547afd379b8953b526709dd2
Author:     Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate: Mon, 26 Feb 2018 16:25:12 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 19:55:43 +0100

dt-bindings/irqchip/renesas-irqc: Document R-Car M3-N support

Document support for the Interrupt Controller for Externel Devices
(INTC-EX) in the Renesas M3-N (r8a77965) SoC.

No driver update is needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-renesas-soc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Link: https://lkml.kernel.org/r/1519658712-22910-1-git-send-email-geert%2Brenesas@glider.be

---
 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index 33c9a10fdc91..20f121daa910 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -14,6 +14,7 @@ Required properties:
     - "renesas,irqc-r8a7794" (R-Car E2)
     - "renesas,intc-ex-r8a7795" (R-Car H3)
     - "renesas,intc-ex-r8a7796" (R-Car M3-W)
+    - "renesas,intc-ex-r8a77965" (R-Car M3-N)
     - "renesas,intc-ex-r8a77970" (R-Car V3M)
     - "renesas,intc-ex-r8a77995" (R-Car D3)
 - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in

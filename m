Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982F2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945D62080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbeLNTsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:48:38 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:54797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNTsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:48:38 -0500
Received: from localhost ([89.204.137.134]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MVvCl-1gxZc10nm1-00RnAV; Fri, 14 Dec 2018 20:48:28 +0100
Date:   Fri, 14 Dec 2018 20:48:25 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio-omap.txt: add reg and interrupts properties
Message-ID: <20181214194822.lvavgczxq4cy7v64@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:W2f8lCThwwl9Q9No+DxfpR0Gbppo1wbu6KNjnxfLsIfqpamtStK
 qGTZ8LOqI97Zo61iPTKphSjfTjqBO9ovAvv4PR/fUyCpYWG0KvLgoE/JGU5oekigsPqcGPj
 aLWOGDKRrNKw8MqDbWHs57WKo7yGVb4bhVk4Jq3nLZs0VrBU1SgarpqLfMwVHSwMsdaQHVE
 V4wBG0MVHPXQ7zwXPqzVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OGWzmNs/hzk=:UQseVi2QISqKHnpGCQD2Ji
 0OB1E17gfdzTVUjIxy6OE2iS0XIOQ+mVxnRYZ2HDzPZSt4E5m1LivHkB5eT5xHSbSWUb1K+hB
 M+ZGoj5y8Kf2Kfz/HM6bTztSYOU8wLxYEc6/lLYftoNsGo4vlrCIvYye4c1TcCC5TdyNry8pD
 P/HyMQlZ1pGoAIxGYOTgGUeBE5cQXgqTEsHYC5Z5Xzux81eSNViW0KDJH7pyUp0N3VIELwlit
 uZeG8SioedFavGZAJh5TSyhILQl9VhsI2DCBqFiJEwV7Qa948ROczzN6sUEXedRImmDNSblkW
 tUrhuvv0CHmBE3Fata45hQ0IUNkvRqFJb7Xg00xrSND4PQJ2EH9EJJSKq3Db258kTILp4scWw
 7Qx2rvZ+qJFI3u+6W+xabo5JIFkSyuBRT7xSoHkArlDdXbcbspOvUYUyg6kIDOMPU3M+Dj+QC
 jObVGPbUiH+pyFCi7HAjlWOdMG+q7F3GVdypIW/EcLKgFRbO7qMDnCffNvzIBj8Ay3CIH5RX3
 WfuvGBz5Vh8aA7vT+3+3O0ScJZkawd0SZr5A5P2+wcanobZxGIh7IyGHk3lhMjU2O70dc9kbv
 4/SPVsu/2kXRt8+b3Fln9cvXIEVsZsY4yk1yXf9FZt9HYXY4pqXwqW4oMv61hDfZOxN9vMzgc
 Ss2ICULgqvPWfj3cfXl4YDtS9gKw/PSr6KlrJNmD6R7y/6cN0fAlNRlxA8ulIoiviUy2lpsmq
 ICZNKcHTilfUls+9xwragqUWVxvni7wSW7ovzcIYG+NltxetMjmVo5bxXRw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document properties reg and interrupts for OMAP GPIO controller bindings

Also add unit address in node name of the example

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/gpio/gpio-omap.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
index 8d950522e7fa..e57b2cb28f6c 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
@@ -5,6 +5,8 @@ Required properties:
   - "ti,omap2-gpio" for OMAP2 controllers
   - "ti,omap3-gpio" for OMAP3 controllers
   - "ti,omap4-gpio" for OMAP4 controllers
+- reg : Physical base address of the controller and length of memory mapped
+  region.
 - gpio-controller : Marks the device node as a GPIO controller.
 - #gpio-cells : Should be two.
   - first cell is the pin number
@@ -18,6 +20,8 @@ Required properties:
       2 = high-to-low edge triggered.
       4 = active high level-sensitive.
       8 = active low level-sensitive.
+- interrupts : The interrupt the controller is rising as output when an
+  interrupt occures
 
 OMAP specific properties:
 - ti,hwmods:		Name of the hwmod associated to the GPIO:
@@ -29,11 +33,13 @@ OMAP specific properties:
 
 Example:
 
-gpio4: gpio4 {
+gpio0: gpio@44e07000 {
     compatible = "ti,omap4-gpio";
-    ti,hwmods = "gpio4";
+    reg = <0x44e07000 0x1000>;
+    ti,hwmods = "gpio1";
     gpio-controller;
     #gpio-cells = <2>;
     interrupt-controller;
     #interrupt-cells = <2>;
+    interrupts = <96>;
 };
-- 
2.11.0


-- 

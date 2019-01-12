Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357F6C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDFB2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfALQVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 11:21:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:36777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfALQVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 11:21:50 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMjgF-1gcZPY1xLb-008Z06; Sat, 12
 Jan 2019 17:21:39 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] powerpc: wii.dts: Add GPIO keys
Date:   Sat, 12 Jan 2019 17:21:24 +0100
Message-Id: <20190112162124.3341-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112162124.3341-1-j.neuschaefer@gmx.net>
References: <20190112162124.3341-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TpDGHZe2O+O8zBRP6TK8+6lMXbL49NlvpGmpjKng9ZctZKOUc/F
 Z72QFHW3FC3AZhCKcnvIuTrIT9ulk96lzwh2dDtaCiqb9UyhwsFVj8ktP9yL510fxtmGEo/
 iOUsG/oUb/4Y+RFHfR/qyjMqGVxgluobN9NM0Bqtlyx9v185yPB25IqsOrR5X0IHa63pfCL
 c6FLyABT5QMUOjyrrPKqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QudKOvcbQuI=:A23n77WeV+djuACoRh6Y8j
 678NyZZPrPqR3R3vbdx3X3mOsHvFMX2y396lh442olJRXGO5vHu0IC6IcTFPbzzfPxtfWwj83
 qjSH46cmUGpI6Yrv4cmxMpnkQ+k12w00oP97M0XUa3GZrr0U1wH1aW55mH6cKrMbgfM+0yFY6
 DfxDbiuMftSkA1IToikBO1CJqF4atu5iF9qcebymCqKGGCdl61lc0UVqjvKtr0nmFIgOAyAj/
 xb+5RKV3qjKDM8rKrLdOc9HJ0UxZKKIZbWaYWxgea9s9Ys4lr2z9trRG1sfqdiOc/uU5TsJR+
 8SLlYe8FaSf2Kr6O6JmWZqHYJPSn/78PyrsOD6vPymxa+x2HYpOjyd+TlPydLopqG4NdHLjKO
 oOkzyN1kzV03K94DqPon2yO0C6YEGJd3ai/d8Vyt9YDyy6+YQSXRur4N87I528OrEnI0GH6H9
 CboNcveO5rgzB0wOsnSZpi96PJjjv2vwFzbHxRFnY9jtEuEqmLCUHSSpVsbgkIXNDVQ0EH3TD
 GTTdVQFJ+R4v9Gnlz+FvdqX7rFU+KNy/6U38nFUsg3iuIKu2Hnn8T/tl1trPH7qK8senj7Mtk
 1RbjOjpIIcc7+lQkpC1g2PC5bKbN7a+jtvcpmH7kQ//+/URa78VcOGOCY3QQTh4YJ6FMnJAXM
 PhtV04jPekaPFv1HhxUEpfJNiMC8NKKusl/kUXu3L4E0OjC3/u+eB4XLdu18wAidkIEY3LMiu
 WnILchWIkPB4EB40h//wZMyio9fwAhSCzOtu2ov5svl5FKb9pOf24Wz3ZksXOFyivvMSbHLrb
 6CEpNwfwQkqKSd4BL9OFWqGntHArkcBBVK6k71XDUytNDS19NtwpRaSo0UJmTlT3CAfs0SDcv
 KYgjgzMGwRyXCrK+Flx8x3t9RYOLiobvbEgqJt4iryGRK2JSjC+GzK44Y2dmS+CajqsVf+onS
 CRbtIEaIFVw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wii has POWER and EJECT buttons, which are connected through
normalization logic to the GPIO controller (the length of an assertion
of these signals is always the same, regardless of how long the user
pressed the buttons).

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/boot/dts/wii.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index 864e5a17aa1d..64f886a6327f 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -14,6 +14,7 @@
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 /*
  * This is commented-out for now.
@@ -249,5 +250,21 @@
 			gpios = <&GPIO 8 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power Button";
+			gpios = <&GPIO 0 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_POWER>;
+		};
+
+		eject {
+			label = "Eject Button";
+			gpios = <&GPIO 6 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_EJECTCD>;
+		};
+	};
 };
 
-- 
2.20.1


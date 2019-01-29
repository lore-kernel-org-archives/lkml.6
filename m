Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BB2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895521473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfA2N7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:59:36 -0500
Received: from mout.gmx.net ([212.227.15.18]:55839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfA2N7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:59:35 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lw2Sj-1hE8682NmH-017lZx; Tue, 29
 Jan 2019 14:59:29 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: rn5t618: Document optional property system-power-controller
Date:   Tue, 29 Jan 2019 14:59:17 +0100
Message-Id: <20190129135917.29521-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:R+qWb7sgwQ4Tm/jjoAzEV2j8uIhovusQMvUcoUP5f/3G1G+0wRi
 p4JLIdVLMNZ/snn5fCzjXDryvRflzYKlhGL3JpOneh2GPhhx7qy/foHLZ5N/mlvM0ch16vg
 w+DThNxn7y5b/5wR4uyVtjYajiGkDZZtvN2803QiQMb0d6PMlo4wcFFOn5QOfY3JSGc7nT5
 vLSKKtXfPRmQCaQmKiG/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NDu8E7r2P5Q=:zMz97WtgOQKZxyKBsVH4WO
 +jZQDl7U2ij/KhJTsmKDuA9ARkZBg0ei9xQ7NSnxujV6iU5gmcw0EoKepPwh5LceOA2GowVOj
 z/tWZFu+fg10JZ8b5cqeYkU4NZTRTimqwYLkOsbjnc3VyvnF9abehGqAWTp2iS7tcn7py5EuK
 Tzg/30xtt2GHv79I5byLrcG54m67N1qE4YKwNLiN/Bv0IBAczc2774V/rIrkipIUmDCZb+p+b
 91jPZ0gJ09XfSmrAo5/kuc6kJMj9cgFJKd3Y9C8N8E7wWTjJVhTozr02+dQ8qkIIzsO+7wDnr
 6zPCnrZA650gzaPWi7ClRDF45aXUH80iAHkV8PBZiGR0N++VdmexeH3fBItMALr30vTvNec/M
 vXB9QY1XAx12PdFS/fz99SXYaW39dE8rfLSF9fBEIjEBtVIn6Gh3s1IavjS0cUXiI/XGSsfCi
 Tu/kCX/X1ppGaA/WnPC0ecvW3PBAsWGuPfmb9aeFwajtfD6b11kNSAyx8Fxif1da3Cap5TYK6
 B9/1j10wXrVWvvwyGElFHFZiEbWNkJ/E3hDKCx1d26Psorh/GFmxPO9JOyPBVJ7mb3mrVpZ/U
 PhSK0eaCGawJo8o2AYETAHTNb6tBx+QWHS/kT56BGohb5rHXwG7wdpDLmbkju6CpOQDFWnUMM
 tDgEJBVoWfxObxfRMX6dlTHIKgmGlEsKG2kcpNqCywR19PkbMD96/W3zC1Qi8KShiqnbpalc+
 ldrxd765PvEIbqVIIwPwF4u3v9MlJU06jYhgwzxVgAbYBt8IZmnz6wfFfZdzXXncbgSkPkUse
 RmSMAsAN55P5oIAuv6AE6p7XVqLmI1cWyHA0HzkHxZJduNauUakNqP+bso53SSW2Mk4pC5jdV
 82VMpDWo+L5sBzDz6yRWGjFOuTgk7ACZ9yQmzOUWjeRMusq0/vp7NUlmKaZFCsv4CDEN8gm2k
 iy0DltHFzeA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RN5T618 family of PMICs can be used as system management
controllers, in which case they handle poweroff and restart. Document
this capability by referring to the corresponding generic DT binding.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/devicetree/bindings/mfd/rn5t618.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Documentation/devicetree/bindings/mfd/rn5t618.txt
index 65c23263cc54..b74e5e94d1cb 100644
--- a/Documentation/devicetree/bindings/mfd/rn5t618.txt
+++ b/Documentation/devicetree/bindings/mfd/rn5t618.txt
@@ -14,6 +14,10 @@ Required properties:
 		"ricoh,rc5t619"
  - reg: the I2C slave address of the device
 
+Optional properties:
+ - system-power-controller:
+   See Documentation/devicetree/bindings/power/power-controller.txt
+
 Sub-nodes:
  - regulators: the node is required if the regulator functionality is
    needed. The valid regulator names are: DCDC1, DCDC2, DCDC3, DCDC4
@@ -28,6 +32,7 @@ Example:
 	pmic@32 {
 		compatible = "ricoh,rn5t618";
 		reg = <0x32>;
+		system-power-controller;
 
 		regulators {
 			DCDC1 {
-- 
2.20.1


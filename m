Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF41206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546949509;
	bh=HuWLDpyq2cRZMk9PjBnq72cbHH8Y0IMGSLixYa93YtA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ySu2envurbIy6BHL/5MTQIAHcA/UnsZyzSVJ+B7RL9HsgGObOWRz7bTjXC7D1gGIS
	 lYrvf48OJf/XtCydc2tJE5qv4aqmlErRdxFvl9d270EmQkMJ9yycuhwg97F0Og3voA
	 Zhmtyf2eRd+5MFzhkkUdq994ZRvOmZiEMs4sO7FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfAHMLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHMLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:11:48 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3FFB20651;
        Tue,  8 Jan 2019 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546949507;
        bh=HuWLDpyq2cRZMk9PjBnq72cbHH8Y0IMGSLixYa93YtA=;
        h=From:To:Cc:Subject:Date:From;
        b=Y5r0yx7/tRPdZtj45MKYmMTtrI2feXdAu2wdN9p/+TGD2sdzwdndAvkY2dDUzn/NG
         wcZPpJKlfdAq4JWJccNwTuhDF+9vPxrTueHUuekFfLGS+Fo13YdJIHn0+z1RXGyot0
         Nw/zaPtWvahDo8rczWXjzY49eBKcs0dH+LLWM2BI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: soc: qcom: Fix trivial language typos
Date:   Tue,  8 Jan 2019 13:11:40 +0100
Message-Id: <1546949500-30044-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix few trivial language typos in bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt | 2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
index 587bb1ddc8cc..1214192847ac 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
@@ -60,7 +60,7 @@ of these nodes are defined by the individual bindings for the specific function
 = EXAMPLE
 The following example represents the GLINK RPM node on a MSM8996 device, with
 the function for the "rpm_request" channel defined, which is used for
-regualtors and root clocks.
+regulators and root clocks.
 
 	apcs_glb: mailbox@9820000 {
 		compatible = "qcom,msm8996-apcs-hmss-global";
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
index a35af2dafdad..49e1d72d3648 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
@@ -41,12 +41,12 @@ processor ID) and a string identifier.
 - qcom,local-pid:
 	Usage: required
 	Value type: <u32>
-	Definition: specifies the identfier of the local endpoint of this edge
+	Definition: specifies the identifier of the local endpoint of this edge
 
 - qcom,remote-pid:
 	Usage: required
 	Value type: <u32>
-	Definition: specifies the identfier of the remote endpoint of this edge
+	Definition: specifies the identifier of the remote endpoint of this edge
 
 = SUBNODES
 Each SMP2P pair contain a set of inbound and outbound entries, these are
-- 
2.7.4


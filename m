Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F87C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB6920657
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="HHh0bvvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfAMPtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 10:49:05 -0500
Received: from onstation.org ([52.200.56.107]:42664 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfAMPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 10:47:41 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 1BF9D16A;
        Sun, 13 Jan 2019 15:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547394460;
        bh=SFvCvTxAWzcYkz0M3vjC3hOAFjxOtLJuScWKRSM0FHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHh0bvvSvBbau1ar2mrgpEh5WSpbnoza6cQNOus4lkIym8XiMJbnIqg2klQRWaKmv
         GpZ6ZscfSH+kQFaszlBrGQY9nEsp8zE+0iqif4uOsY/1w5FIGFkl7j/Qsr3zIEVLKk
         FlME/8+jKK2V2IYFASUFkNw9NE4iViNRSJIBXpjI=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 01/14] dt-bindings: pinctrl: qcom-pmic-gpio: add qcom,pmi8998-gpio binding
Date:   Sun, 13 Jan 2019 10:47:03 -0500
Message-Id: <20190113154716.5145-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190113154716.5145-1-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the PMI8998 GPIO variant to the Qualcomm PMIC GPIO
binding document.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
This is a new patch introduced in V4.

 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index 759aa1732e48..7f64a7e92c28 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -19,6 +19,7 @@ PMIC's from Qualcomm.
 		    "qcom,pm8998-gpio"
 		    "qcom,pma8084-gpio"
 		    "qcom,pmi8994-gpio"
+		    "qcom,pmi8998-gpio"
 		    "qcom,pms405-gpio"
 
 		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
-- 
2.17.2


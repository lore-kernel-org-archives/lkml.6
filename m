Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671EDECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BF220652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BF220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeGTIkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:40:19 -0400
Received: from mout.perfora.net ([74.208.4.197]:33033 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeGTIkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:40:19 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Leswr-1gNTsC0d0Z-00qfFC; Fri, 20 Jul 2018 09:53:07 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ASoC: sgtl5000: fix spelling in devicetree binding document
Date:   Fri, 20 Jul 2018 09:53:02 +0200
Message-Id: <20180720075302.21079-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:MZHnGfGdQwHFU6cx9NjXpe4fMBjlDSiDVugQnnudocoBi7VVsDz
 KwE869sfoYkfIIiSMkp9b/LcuBlKvaS9825wIsdQkxgsmst/UJgKqo6KJuv58nn2njN5gY+
 x1In5uECtoZFSTLFn73dLl8olILbtItzSs0NgEJYbxNrGzdZLmGTw077dYjRie1pHFt/QBL
 7L8OnnX/PfyEWX0YZe2kA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b77JtsX/zJ4=:XmfL9HT8G42bT/DytKa1zX
 qOqUnJTSD2TLAOLZvjagigyF+1G8eaKmvoJpQVROYEmjY57Mt/WF1I5KHNQPXWfURwsHFNrxj
 LFQA0Q5jgsdi+R1+5PG8moNWOzkS6JXySdjHOYpAuAswAW363WoMm2ibz+xNRMGL5IpCd+c96
 xd60vq41f07BDolMs2flulPIWGwsAdOjXApNe+ftUAaWPlStflfvw41c2xYGDj6ZVChIUnw13
 aT+OPox7BrOqLUHPhmXUp14l/ewV8VqC9He0LqzPwmkt34gl+YDrqTfEb/INm4DZr+8Moa77H
 YwKanaRJgYK4bIcS55q9JLAb3mqyV991TutRRqHJmTKqqs1noqZyfpotOPH9DBZmS/aKh/yw2
 9PnW5VLJgE6zxOEf1FvjvDzQ5LUHPPTOyGwlpJey0M2GoDpXw2G1ZH59p+aJe6L7m5NLiLc59
 OtExP1DwWHoSeOFGPdy8EC6FBayS6C9lj/9AtVuhRNG2IWkfJ+kcpe3GlPU5BI43zW1UJW2Oi
 MP5Y2I8VDH9KUKOJvbJFe+MPdvmuULVyY8CAgiJ+zN8MUbKx0wvW6H8OcAk4GcaAZjKk1/tZ4
 9RiGVufOXCwkTkYeN+tCwjdty/aGY0/Y479VsLqo2l0SvPfLjzOIaGCoZA/kTgV85CmAupan2
 5W7vlgRQa2sv92BRMkQHSc1mt6eDGVnus6SpQae8HqSVgi6an64MiY30FFlWjD0PCijZAnycM
 UIbKU6es+R2MLTlbtnZkEOo/59uEqmXfAOE7s6S2B8gA6hzXAtimwcEki8ahd6/7QbETK3vln
 IewaNZofOMfRxMWDaul42D/wDCCu3BBtXuM5Yv5QlOVk7JhaeK6WmK2IbOWX+vgmLJX1ery+t
 jKofBQJJ/Vai543R4Kg2OSH3MT6C+tMN0hCzfjYsE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes a spelling mistake.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 Documentation/devicetree/bindings/sound/sgtl5000.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 0f214457476f..9c58f724396a 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -17,7 +17,7 @@ Optional properties:
 
 - VDDD-supply : the regulator provider of VDDD
 
-- micbias-resistor-k-ohms : the bias resistor to be used in kOmhs
+- micbias-resistor-k-ohms : the bias resistor to be used in kOhms
 	The resistor can take values of 2k, 4k or 8k.
 	If set to 0 it will be off.
 	If this node is not mentioned or if the value is unknown, then
-- 
2.14.4


Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99ACC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B048D20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RWvdKCFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B048D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeLMKOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:14:17 -0500
Received: from m50-133.163.com ([123.125.50.133]:57819 "EHLO m50-133.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbeLMKOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=/Gi+1q/2cbJjR4NvFl
        3kkqN2sOoyFHOo9tu433oyx+U=; b=RWvdKCFLYW9GHcpLWQwn4iAtWIx2VGYemD
        +HEIO5Ux5jt1rkJmrXawlWA+2L+fGFXwkICBRqiST6S/Nd63jc/GFGmre77vCW9i
        wYcGXlGEdU807ns1fQBFl+Dk8OpeYTmXg908tOnEzgqh1piOU58xrRsn1gKZI8vG
        KHsVnJjiE=
Received: from localhost.localdomain (unknown [221.0.93.75])
        by smtp3 (Coremail) with SMTP id DdGowAD3P+LcMBJcePuXAA--.86S3;
        Thu, 13 Dec 2018 18:13:55 +0800 (CST)
From:   Dianlong Li <long17.cool@163.com>
To:     robh@kernel.org
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dianlong Li <long17.cool@163.com>
Subject: [PATCH 2/3] dt-bindings: rtc: sd3078: add device tree documentation
Date:   Thu, 13 Dec 2018 18:13:49 +0800
Message-Id: <1544696030-17159-2-git-send-email-long17.cool@163.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1544696030-17159-1-git-send-email-long17.cool@163.com>
References: <1544696030-17159-1-git-send-email-long17.cool@163.com>
X-CM-TRANSID: DdGowAD3P+LcMBJcePuXAA--.86S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4kWw45WFW7Ar4rArWfAFb_yoW3Zrg_Ka
        1xAa48ua98tF1Fgan5CFyDtryUKF1xKrs7A3Z8JwsYy34IvayjqFyDXw1jyw4UurWI9w15
        ur18JrWvyrnIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8k-BtUUUUU==
X-Originating-IP: [221.0.93.75]
X-CM-SenderInfo: 5orqwi2xof00ro6rljoofrz/1tbi8A4cF1uoQwNCsAAAs0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree documentation for the SD3078 device tree.

Signed-off-by: Dianlong Li <long17.cool@163.com>
---
 Documentation/devicetree/bindings/rtc/rtc.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index 7c8da69..e46edab 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -62,3 +62,4 @@ ricoh,rs5c372b		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,rv5c386		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,rv5c387a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 sii,s35390a		2-wire CMOS real-time clock
+whwave,sd3078		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-- 
1.7.9.5



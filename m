Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-602900-1522321657-2-7851512025237014480
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522321656; b=F2WLnxe8yX36faklJCU4yofrKuLHm3ItwsEDY3JluMgeRFQ67r
    yoTYGEWVJIpm0844vwxYPbrVujEhXKBvsRPET+xqt+rwHPTtV5VIvBqd8UqTFOVh
    y8LWfYvL0vwXSIsUblaneoEPmyGEftqiUt+M9cCYST/pUJbBPFl+5MUjdOGPOvAO
    SI/Puqfp/zybaaY4pjdFmAdMaFi7LcuClNF8r7iqjq5vIXdP1qNzJIZKl7CGV64T
    XhfnLUxLPbubKvYQ3d+tOoBH6nmz6OKs5t7LxSp5Fdtp8uH5rD4LTXpr8HGipW9w
    OgsBTjx8M5Gx3s6bUFRr4oqbA0rU9he5rX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522321656; bh=
    q2nJnVCCMQktDubYQ0edsCwAphGmRPG5GkTvt+PauBY=; b=rNsRUohBoh/LxgNs
    E2yz4YGtqsBOC7nUmFLvYYQGV13nt2UmWwlN3t8g6oJIiAuT2RojHuG66VdkPFBS
    zqfCRhiY7X1H/9P7a9CVIIPSLKnXLRercO6RgodRTC2VxJ1Wh1BL3psLhJ3Nu02z
    q54ZE/9BQU2P0RGsamWFOGqzA8PYoR6FDfCYAA4u689fYAiWwq4KkRMn8MXYERr3
    xC3e/uWAPgSDSmaPVJ9UTdBnLr2wkkcXzH9xiEprrPuM5WHPml9M8PRIW9hTGE+K
    RoOPiXnnfMiI2S4aXtI71jQcT/BVFc+jDFgDwaFkvQbdv06zoUPBP3kofnWXWwZC
    qVJ/Tw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=T2/Hxlgq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=WyBuu7gj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=T2/Hxlgq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=WyBuu7gj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAfjAwQkoVFthuoFIfppdtueS+mWFhu88cDcX/mdhhovtpnlMGLecIWit+HOmCf/0pd3jACWOjDeyT7WYCdovVgAnocGlLQ709F2ZvdV5Gfs52yKW0db
    pYWyaD2WvxCViA7dzv+7tnYxMJIz7rrDxwZhaKD/1fEhRnbZkQLxPwqIpVaxAmpU/WrNrBVUg/U1G/lLheY3cSbnTC+As9S9jjxctrC/m/MxXw08nARWnjoe
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=LpQP-O61AAAA:8
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=f9Bc9jwrbPSyHNToSH4A:9
    a=pioyyrs4ZptJ924tMmac:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeC2LGW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 07:06:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43542 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeC2LGT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 07:06:19 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 161BF601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>, robh@kernel.org,
        sboyd@codeaurora.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, vivek.gautam@codeaurora.org,
        evgreen@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        stable <stable@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 3/7] phy: qcom-qusb2: Fix crash if nvmem cell not specified
Date: Thu, 29 Mar 2018 16:34:22 +0530
Message-Id: <1522321466-21755-4-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Driver currently crashes due to NULL pointer deference
while updating PHY tune register if nvmem cell is NULL.
Since, fused value for Tune1/2 register is optional,
we'd rather bail out.

Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips")
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Cc: stable <stable@vger.kernel.org> # 4.14+
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 94afeac..40fdef8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -315,6 +315,10 @@ static void qusb2_phy_set_tune2_param(struct qusb2_phy *qphy)
 	const struct qusb2_phy_cfg *cfg = qphy->cfg;
 	u8 *val;
 
+	/* efuse register is optional */
+	if (!qphy->cell)
+		return;
+
 	/*
 	 * Read efuse register having TUNE2/1 parameter's high nibble.
 	 * If efuse register shows value as 0x0, or if we fail to find
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

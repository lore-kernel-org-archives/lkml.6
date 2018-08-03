Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F268CC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49CA21708
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="H0GgrTw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49CA21708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbeHCCMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:12:53 -0400
Received: from onstation.org ([52.200.56.107]:33992 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732384AbeHCCMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:12:43 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id A6EEF2A4A;
        Fri,  3 Aug 2018 00:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1533255548;
        bh=xJJpo/Hp9rxSc8OyVWo1VZsGDRR9lIvTjK3TL8P9sCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0GgrTw36eWt+R9nekdsBjfDTDU9v2dXxXGqWbf0B1S7tBvzMLOmJGty9o1W0M31V
         QkbM1LcntgNvZoWO1AtvgRHEULU+gvrhWGXL5zXINoICl2CmRFwJ015mTIYia0fq8C
         cPotrX62tR7094GF3InuC94eqKAcHi4TbI3A2E4A=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: [PATCH v3 8/9] dt-bindings: iio: tsl2772: add binding for avago,apds9930
Date:   Thu,  2 Aug 2018 20:18:59 -0400
Message-Id: <20180803001900.25371-9-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803001900.25371-1-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds avago,apds9930 to the tsl2772 bindings.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 Documentation/devicetree/bindings/iio/light/tsl2772.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
index 4e7d98627cbf..1c5e6f17a1df 100644
--- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
+++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
@@ -13,6 +13,7 @@ Required properties:
 		"amstaos,tmd2672"
 		"amstaos,tsl2772"
 		"amstaos,tmd2772"
+		"avago,apds9930"
   - reg: the I2C address of the device
 
 Optional properties:
-- 
2.17.1


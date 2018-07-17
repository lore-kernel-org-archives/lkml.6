Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C9CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD94B20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="uPxvmAnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD94B20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbeGQJOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:14:04 -0400
Received: from onstation.org ([52.200.56.107]:58256 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbeGQJNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:13:36 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 79C2C10D8;
        Tue, 17 Jul 2018 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531816926;
        bh=giummQqSYmYHyU6UkIYZlgBsDuzUHX1vjGwpbKH+srM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPxvmAnMAb3Trl4aC0BjBdl2TrHaTtdjW4KqnwZhYrnYkNDBg2IDb4nVW2mbcENzZ
         biFr5ANM9KhkSkht8GTPdekWB8hO/FnTUUIUcdbnN57hlCv9UJKdkqWasmKiHO2Awv
         B9Nts0vS7PaT0P1+mTVJLwMv4ftogzSI5QErdY00=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: [PATCH v2 4/7] dt-bindings: trivial: remove tsl2772
Date:   Tue, 17 Jul 2018 04:41:55 -0400
Message-Id: <20180717084158.23532-5-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717084158.23532-1-masneyb@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the tsl2772 driver from trivial-devices.txt. A separate
patch added the binding information to the file
Documentation/devicetree/bindings/iio/light/tsl2772.txt.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 Documentation/devicetree/bindings/trivial-devices.txt | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 763a2808a95c..a977ccef7230 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -21,16 +21,6 @@ adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
 ams,iaq-core		AMS iAQ-Core VOC Sensor
-amstaos,tsl2571		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2671		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2671		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2771		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2771		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2572		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2672		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2672		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2772		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2772		AMS/TAOS ALS and proximity sensor
 at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
-- 
2.17.1


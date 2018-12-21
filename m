Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=FREEMAIL_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E047C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB92F21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbeLUQpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:45:42 -0500
Received: from mout.gmx.net ([212.227.15.15]:44687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeLUQpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:45:42 -0500
Received: from macchiato.fritz.box ([84.118.159.3]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MQQzk-1gxaBL1FoS-00TmfP; Fri, 21
 Dec 2018 17:45:15 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI area
Date:   Fri, 21 Dec 2018 17:45:03 +0100
Message-Id: <20181221164503.5128-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NTsIIujFJRNYukWdFSnzEwLKoB+tAHo8mjNhGy1vmiPMhNrt9yB
 0RV2/cbI8AFWbZeEw/cR3Tx5fgzAtQK/oDQNowpRvsGqJ+90JoEpmTcruX7R8Vhtpy6n6oj
 U3sGGP8Ll9FsIcAVT1NSa0ZdMGsX7M/SS5wNKcXwJYRYn5QwhRCR6bgwpjwQxJAjel9soWQ
 GiFCH9CRO8Gjejs7vAMJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PVgJ3hldQEA=:+XLn2eHOpxnvM1urPXFi16
 Rp3g3T1TN/jEjhE43tMT0huQ7SSuXzJX51aEiNOE9ssqu6FFD9Mi/oKQAFNhtuFybCb1cstVD
 6D6i2gcWmp/n9flRpl5ZEUqJwg7CHRNVUXtAsM1chOGy3IUATcvTzTIl2YOSOyCroPewvnOHZ
 uanUTICmSSeGExkJ4wYtL1VOwoRCWGIaSRxO6EhDTOMOj878nawlgZVzj7vqSgX2qvghywByX
 +w6JkJxpXstkWQGDR8SUAl+9pZPNnxR9Dupch3lSyRp7txbrTa0EGuWEsB95tWdyXf7kp0VAy
 Rxof1wl8mjaW+gR1PonHHmTHWVig19/ePUfIBDKBLVnJCOafeVMBmofMdSQOK/PLm528y5ZUP
 pHuKYnuAuVDV8VGxtkq9AVNoV3wESFxDf0mSpxMH9F7OpqihyxZZoUH0FMHlThyk424Ri4WVL
 4o0FbK+xKsn1IXmCSoh2e9ZkxH5R8baTF9ANbGlFoJ+GGZWi1SYNs8I+baXuxkI6f3gjEg4bN
 JvafrbF6EnAArUEWGiRUFFPVIvq+MTWkalmRyOiRPqAAhZZEWvXetPLr3poj2s63usjW4yMt0
 ssAuT7YjHaP3E2kT0HvaUMd+J1s3e2XtUhwHCzF9ZFBHu54n7xV/jJPT8P7Cyg/ZMV3DSQa7p
 hrfdKm/88dEzQ4Ijj8UwlDQcj11fH1hf2A/fQS3hEyA/XViiyjKj+0oJnx56iiTI1U9SUiB+/
 PPSz4MSoek8uZ7unzg++ehoRuKmfFbyqBaEcAt4Sl8kZX+OLnwDctBBt/So3nvSumgamQg9Ge
 6CU89qDxA0X7k+b7W3zxAUXp7Mq8N4i2/Xo8snXdTVjzjVqFo7vxGjnor5Amsyqt0zyD4kssh
 bIiwUnPdKwdW0jz7PIDuZohnn2H/DHOx8rEFrq6M09i+NJPirWN1W9AnwiQpSi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
attempt to access it from Linux leads to an immediate crash.

So let's make the same memory reservation as the vendor kernel.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
v2
	Move the change from armada-8040-mcbin.dts to armada-ap806.dtsi.
	I only have a MACCHIATObin for testing but
	https://github.com/MarvellEmbeddedProcessors/linux-marvell
	has the reservation in that file.
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 7d94c1fa592a..f8dafef83db0 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -28,6 +28,17 @@
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		psci-area@4000000 {
+			reg = <0x0 0x4000000 0x0 0x200000>;
+			no-map;
+		};
+	};
+
 	ap806 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.19.2


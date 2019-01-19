Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44046C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE372084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfASUTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 15:19:15 -0500
Received: from mailoutvs7.siol.net ([185.57.226.198]:33325 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729212AbfASUTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 15:19:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id F00DD522DD6;
        Sat, 19 Jan 2019 21:19:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UpFhR1vvG_GX; Sat, 19 Jan 2019 21:19:11 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id AE67B522DCF;
        Sat, 19 Jan 2019 21:19:11 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 2202D522DE6;
        Sat, 19 Jan 2019 21:19:09 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v2 2/2] arm64: dts: allwinner: a64: Orange Pi Win: Enable IR
Date:   Sat, 19 Jan 2019 21:19:00 +0100
Message-Id: <20190119201900.26592-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190119201900.26592-1-jernej.skrabec@siol.net>
References: <20190119201900.26592-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangePi Win board contains IR receiver. Enable it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 8974b5a1d3b1..8642db86ac68 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -180,6 +180,10 @@
 	status =3D "okay";
 };
=20
+&r_ir {
+	status =3D "okay";
+};
+
 &r_rsb {
 	status =3D "okay";
=20
--=20
2.20.1


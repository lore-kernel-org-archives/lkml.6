Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73678C00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF9220663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfBXQWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:22:49 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:38697 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfBXQWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 11:22:48 -0500
Received: from localhost ([2.174.161.193]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MXY2T-1gWA0X45hX-00Yzih; Sun, 24 Feb 2019 17:22:15 +0100
Date:   Sun, 24 Feb 2019 17:22:10 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     afaerber@suse.de, arnd@arndb.de, davem@davemloft.net,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        jic23@kernel.org, johan@kernel.org, khilman@baylibre.com,
        knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh+dt@kernel.org, robh@kernel.org,
        songqiang1304521@gmail.com, treding@nvidia.com
Subject: [PATCH 1/4] maxbotix,mb12x2.txt: add dt doc for maxbotix,mb12x2
Message-ID: <20190224162208.esbrzartgfqxptsw@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:EnD4YfYGacd6T82DnaP4hM+o357CVZ4+RYzT8F3PLLFg2RWGONy
 8sBVeLWZIoRUqTlFHsq+AtFAxyBVHOzp+PhzaQCvGMLrXhDGecztLVcWtknWQpNi5BE38QC
 LamcnbMi8tEucJP5GbT5miUrFvk8Y/2eU6YlwwYzl1tRjptgNpQRZOv4KP6ftCIhOoIAVAH
 fdkfTBpZuNJLjezPSLtlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HHCYuhzPp/s=:SToP2DErdkd/YZEmxVd6z/
 Q3/He8W0CsBlsIM4poCIiBNAWDYdP+h5BEqKvIlkoyp+RwA9s4j/Uf/7fOYpuH5igIFCD2nEF
 9+24NahcU+ge5qep3jolZ/p4jymZgAn6k5zt5uTATMCp72pTFHeD8B+tiqJRg+vrzDqMN9I23
 GDVMdOXVCdTaoKA+lnzM7H4YI+amSCT/CeEUCUI1AcB+/qQRS6OwWJLbHWDyzdxuBjLxREhl9
 HlP2aopbyTw0/AoGPaTwnatWb81fxnAFiJbKgnkrdet2Z0gl406aFhdgWlkQl1/fb9F2GsuWw
 OWL/cpbaGBz1iyT7cBEZDzvFwk1vV6XESm6jjQxx2QWCuylV4tx0pXYs6F+VnWLuRYheB9lkp
 u2mGd7vA7ilbv5EBcFsluTs6LRrew3HbInwyA7ADR7i/kC0/cO70ixH0x2MPAanuWgKEtJw3N
 MUXhttZ33pr4FnyZTJ1g6yEvD5yIBUWoUAsa7E/sRGOvIOk3DNtqIIpumCUaj3twB9oiVkY1c
 OZSif9cpb15MWyRxpEOHUQFEZvEWeaQ4gWiU3LChhpl7vXv58NBVBv/QorFxg/EMXSajhmRBz
 GxbBId7cnGmK9JcEB3NgnGb7BYT2zrEAl2WhxGJJvPsTA/PlxdoCNsUHWcAehOgyB+qh+44tN
 /hKgCV/iPQPRZXwB/WvpPS/Rho1J3rHxEfvqMWn6doZinp3Am7C0WyRHoMayqI2LuaRisjEjD
 6lG5fyorYsmp3pxwiFsaYlwZYmCCZd1XKEkV9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add dt doc for maxbotix,mb12x2 and also a new vendor prefix maxbotix

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/maxbotix,mb12x2.txt     | 22 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb12x2.txt

diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb12x2.txt b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb12x2.txt
new file mode 100644
index 000000000000..29f7fc09cfdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb12x2.txt
@@ -0,0 +1,22 @@
+* MaxSonar-I2CXL ultrasonic distance sensor of type mb12x2 using the i2c
+  interface for ranging
+
+Required properties:
+ - compatible:		Should be "maxbotix,mb12x2"
+
+ - reg:			i2c address of the device
+
+Optional properties:
+ - status-gpios:	Definition of the status gpio (input) which is used
+			to announce the preceding reading request has
+			finished and that data is available. If no status
+			gpio is specified the device driver falls back to
+			wait a certain amount of time (15 ms) until data
+			can be retrieved.
+
+Example:
+mb@70 {
+	compatible = "maxbotix,mb12x2";
+	reg = <0x70>;
+	status-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..added54a1108 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -225,6 +225,7 @@ lsi	LSI Corp. (LSI Logic)
 lwn	Liebherr-Werk Nenzing GmbH
 macnica	Macnica Americas
 marvell	Marvell Technology Group Ltd.
+maxbotix	MaxBotix Inc.
 maxim	Maxim Integrated Products
 mbvl	Mobiveil Inc.
 mcube	mCube
-- 
2.11.0

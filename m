Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeBEPqd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:46:33 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16451 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753326AbeBEPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:45:41 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180205154539epoutp025545040c3d2c1865bc0f485a93262040~QeHnfcnC_3222732227epoutp02N
X-AuditID: b6c32a35-879ff70000001031-a5-5a787c22335c
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 8/8] ASoC: samsung,tm2-audio DT binding documentation update
Date: Mon, 05 Feb 2018 16:44:03 +0100
Message-id: <20180205154403.13520-9-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180205154403.13520-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCmrq5STUWUwe55fBZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xeE37awW
        F1d8YXLg9djwuYnNY+esu+wem1Z1snn0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxt6up8wF
        O/gqFv7bwd7AeIO7i5GTQ0LAROLMxA6WLkYuDiGBHYwS8499hHK+M0pca7jIDFN18PUvRojE
        bkaJf2+mMkE4vxglpjUuYgOpYhMwlOg92scIYosIiEncntPJDFLELHCGSWL6vjVAHRwcwgI+
        EtMWgU1lEVCVWL54GyuIzStgLdG++h4rxDZ5ifcL7oPN4RSwkdhzbxnYZgmBPWwSl3b9gCpy
        kWg9upIdwhaWeHV8CzvIfAkBaYlLR20h6vsZJU6saYZqnsEocad9AhNEg7XE4eMXwQYxC/BJ
        vPvawwrRzCvR0SYEYXpI9N7Uh6h2lFi//Q00WIBm7p9xnWkCo9QCRoZVjGKpBcW56anFhgWG
        esWJucWleel6yfm5mxjBMa1luoNxyjmfQ4wCHIxKPLwCGRVRQqyJZcWVuYcYJTiYlUR4na6X
        RwnxpiRWVqUW5ccXleakFh9ilOZgURLnDQhwiRISSE8sSc1OTS1ILYLJMnFwSjUwTo5OjOU5
        rM53MMvstI/OFbubp0TSVgVE3zJ7J5/F437mutLU7gtHHFd/15ov1/CXe+mXCzF3BZdI2Bq1
        FXbvfZR3f8GssntVJp/OpCd82vI4yeXUAbHZvs+4+z7MXLbhqcryl0vaZ+Q/8d+86+Aurm6d
        lR/c/j8NmpHIzXN//44nCXtlG8y1a5RYijMSDbWYi4oTAR12NEDlAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsVy+t9jAV3Fmooog51NphZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xeE37awW
        F1d8YXLg9djwuYnNY+esu+wem1Z1snn0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxt6up8wF
        O/gqFv7bwd7AeIO7i5GTQ0LAROLg61+MXYxcHEICOxkl7n7qYQVJCAn8YpR43asHYrMJGEr0
        Hu1jBLFFBMQkbs/pZAZpYBY4wyTxZeIl9i5GDg5hAR+JaYuYQWpYBFQlli/eBjaHV8Baon31
        PVaIZfIS7xfcB5vDKWAjsefeMkaQViGgmqabAhMYeRYwMqxilEwtKM5Nzy02KjDMSy3XK07M
        LS7NS9dLzs/dxAgMv22Htfp2MN5fEn+IUYCDUYmHNyOrIkqINbGsuDL3EKMEB7OSCK/T9fIo
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry3845FCgmkJ5akZqemFqQWwWSZODilGhgF58yKEc6o
        kJxelr530Xyl+LAvkzZL3bywM8n97oWJFvvSdhzWnFW7b4ki2/GgM3cchDv4pI4Jvv/7cjOT
        ZuK2LQve609nnLtFtu2Eeu6Ok/Ey4ZIdSxk5X+6tFP7NJSKRmSX3McdtcceH1enLWucdKrXz
        26W6cxX/Ohv22WeDCiuP77P5OO2hEktxRqKhFnNRcSIAnMNM7DsCAAA=
X-CMS-MailID: 20180205154537epcas1p10a9a30a574e3f472358e7dacf3cb0489
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205154537epcas1p10a9a30a574e3f472358e7dacf3cb0489
X-RootMTR: 20180205154537epcas1p10a9a30a574e3f472358e7dacf3cb0489
References: <20180205154403.13520-1-s.nawrocki@samsung.com>
        <CGME20180205154537epcas1p10a9a30a574e3f472358e7dacf3cb0489@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents additional entries of the audio-codec and
i2s-controller properties required for the HDMI audio support.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 .../devicetree/bindings/sound/samsung,tm2-audio.txt        | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
index 94442e5673b3..f5ccc12ddc00 100644
--- a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
+++ b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
@@ -4,9 +4,13 @@ Required properties:
 
  - compatible		 : "samsung,tm2-audio"
  - model		 : the user-visible name of this sound complex
- - audio-codec		 : the phandle of the wm5110 audio codec node,
-			   as described in ../mfd/arizona.txt
- - i2s-controller	 : the phandle of the I2S controller
+ - audio-codec		 : the first entry should be phandle of the wm5110 audio
+			   codec node, as described in ../mfd/arizona.txt;
+			   the second entry should be phandle of the HDMI
+			   transmitter node
+ - i2s-controller	 : the list of phandle and argument tuples pointing to
+			   I2S controllers, the first entry should be I2S0 and
+			   the second one I2S1
  - audio-amplifier	 : the phandle of the MAX98504 amplifier
  - samsung,audio-routing : a list of the connections between audio components;
 			   each entry is a pair of strings, the first being the
@@ -22,8 +26,8 @@ Example:
 
 sound {
 	compatible = "samsung,tm2-audio";
-	audio-codec = <&wm5110>;
-	i2s-controller = <&i2s0>;
+	audio-codec = <&wm5110>, <&hdmi>;
+	i2s-controller = <&i2s0 0>, <&i2s1 0>;
 	audio-amplifier = <&max98504>;
 	mic-bias-gpios = <&gpr3 2 0>;
 	model = "wm5110";
-- 
2.14.2

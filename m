Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964941AbeBLQRJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:17:09 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:12894 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964927AbeBLQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:17:03 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180212161701epoutp03bbd8bc31142f405299020f5d855dabe3~SoEASiuqz2297922979epoutp03C
X-AuditID: b6c32a45-3ebff70000001023-a8-5a81bdfc3a0e
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 5/7] ASoC: samsung,tm2-audio DT binding documentation
 update
Date: Mon, 12 Feb 2018 17:15:36 +0100
Message-id: <20180212161538.22669-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180212161538.22669-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7bCmhe6fvY1RBotazS2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i8Nv2lkt
        Lq74wuTA67HhcxObx85Zd9k9Nq3qZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujD2Tr7AU
        TOWvOLzxHGMD42qeLkZODgkBE4mbH9axdjFycQgJ7GCU6GmayQ7hfGeUmPhrEztM1azHO6AS
        uxklfrW3sEE4vxglvv3tZgKpYhMwlOg92scIYosIiEncntPJDFLELHCGSWL6vjVgRcICgRJd
        a5uBEhwcLAKqEou3J4KEeQWsJfrfnIHaJi/xfsF9sDmcAjYSky4vZwKZIyGwg03iac8TJogi
        F4mHS95ANQhLvDq+BcqWlni2aiMjREM/o8TH4/tZIJzVjBKvv+1ihaiyljh8/CKYzSzAJ9Fx
        +C87yEUSArwSHW1CECUeEs/PbWSDsB0lFhx5yATxMtDQrilTGScwSi1gZFjFKJZaUJybnlps
        VGCoV5yYW1yal66XnJ+7iREc11quOxhnnPM5xCjAwajEw/tgbmOUEGtiWXFl7iFGCQ5mJRHe
        P81AId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxtAS5RQgLpiSWp2ampBalFMFkmDk6pBsa0ucJz
        p1w1LmP0bOKOtLyRrVNjsiAyWdx/I2++sIPYxaet9ufOB3XE35yxenvK6jdJSonP+s94qPis
        jtqenjl3SUVH4F8uY/H4dduXCd9luhL1YZfVwcbz0b++uVVI+EkcevbzZKXwOf/+Ke6+26es
        U1bb3XFeJ+HO8YOXw+tung7hW/r9gbUSS3FGoqEWc1FxIgA2cQOx5wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t9jAd0/exujDM5eELa4cvEQk8XGGetZ
        LaY+fMJmMf/IOVaLt/u7mS3On9/AbvHtSgeTxeVdc9gsZpzfx2Sx9shddovWvUfYLQ6/aWe1
        uLjiC5MDr8eGz01sHjtn3WX32LSqk82jb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4MvZMvsJS
        MJW/4vDGc4wNjKt5uhg5OSQETCRmPd7B3sXIxSEksJNR4tPyWWwQzi9Gic49S9hAqtgEDCV6
        j/YxgtgiAmISt+d0MoMUMQucYZL4MvESO0hCWMBfYuustUANHBwsAqoSi7cngoR5Bawl+t+c
        YYfYJi/xfsF9sDmcAjYSky4vZwKxhYBqjixfzzyBkWcBI8MqRsnUguLc9NxiowKjvNRyveLE
        3OLSvHS95PzcTYzAENx2WKt/B+PjJfGHGAU4GJV4eDtmN0YJsSaWFVfmHmKU4GBWEuH90wwU
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwOiwkbV401L/
        d9rfUu9y30nRXXPYeIHcndowtfpHZsF3pt7lzpRuqr/yiJF/1Rk1LZWfvTKpj4qCelwvnS9m
        /uynfPqFcNqDlRPY/UMeFv7gnlHPWRSyum7iMvvQH1/FS+brGsVt8fy53f/KWv152v3uObdX
        ndAJyZz/2aok7llN+kdb3dqNwkosxRmJhlrMRcWJADKXGm49AgAA
X-CMS-MailID: 20180212161700epcas2p3f810196ade27315587602b16707755c6
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180212161700epcas2p3f810196ade27315587602b16707755c6
X-RootMTR: 20180212161700epcas2p3f810196ade27315587602b16707755c6
References: <20180212161538.22669-1-s.nawrocki@samsung.com>
        <CGME20180212161700epcas2p3f810196ade27315587602b16707755c6@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents additional entries of the audio-codec and
i2s-controller properties required for the HDMI audio support.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
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

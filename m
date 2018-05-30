Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753771AbeE3MTA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:19:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47713 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeE3MQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:16:30 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180530121628euoutp01a7e65c398b5a5d96c84cbc38006175db~zazh4y5-B0845908459euoutp01h
X-AuditID: cbfec7f2-5ffe19c000011644-44-5b0e961a0896
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2 05/10] panel/hv070wsa-100: add DT bindings
Date: Wed, 30 May 2018 14:15:56 +0200
Message-id: <1527682561-1386-6-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2Sf0hTURTHu3vv7T2Xk8dceLOwWBRl+QstLlSSKPQggoJ+oZAte0xTp7zn
        TK1lhNrm8McU3bLoFxWxVumUaSsNp22YOJuWmWKKkmZqgmFQlObc6r/P+Z4P95wDl8IkRUQw
        labMYTmlPEMmFOFWx09XWHBtQFLk7NQeNPTURaAyV5cAXdXMEajB+IxAtztXsneL80JUNVqJ
        oy+f3DiqmJjBUG9vPYl6rs6SSKu/TyLLxACB+m03hcjY2yZAd6aHcPSkc4REDz64Bai4tZNE
        xuppIfppu4UfWMeYb5kB019eJmCe142QzA3NdYKxmLRCpvnHGMGM6pwCpvF+IVPeZALMd0vI
        EVGiaN85NiMtl+UiYs+IUodtA3i2lsobbyrBroBlYSnwoyAdA80VU7iHJfQjANvrC0qBaIW/
        A/jrs434L41aSG/jIYAaxxzuLZYBnLL/XrEoSkiHQvO1ZE8upU0ANg7OAU+B0TUEfHt7ZlUK
        pPfDZVuCB3F6K3ztiPUMENPx0NVlJr3DQuBHlxbzKH50Anz8MtbzCqR1JDQszfq2ToDThkmf
        Hwi/Opt8vBH2V+twL2fB4skJX54H28q6fcfshR1O9ypjdACsshpWZ0FaDDUlEq/CwOctOt+9
        BgDr2n+TlWD9HbDGBIJYFZ+pYPkoJXshnJdn8iqlIjwlK9MCVv5G95JzoQUs9p21A5oCMn9x
        5ClxkoSQ5/L5mXYAKUwmFata/ZMk4nPy/AKWy0rmVBksbwcbKFwWJD69/XKihFbIc9h0ls1m
        uX9dAeUXfAXEqTevVd89/KL2PNqSp+goipcH/+lJPFSz88aYSn2sDTkvRe6Jdt8bdDn0D4cf
        nNBvc0uLNqUYv3Viu2lX/qsGNz/ux4TtWlBaT3BqqaYhvS+sMKtLX7V0F0Y3m7l5bVzE0Q4u
        ZeOB99bGwFDXsdaD/Y8CdhyPGTRdfJMae1Itw/lUeVQoxvHyv60wuX8XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xy7pS0/iiDY5uYbO4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErozbu66xFHRyVDza0sbcwPifrYuRk0NCwERizf1N7F2MXBxCAksYJfb/PcsI4TQy
        STx51c7cxcjBwSagJbGmPR4kLiKwilFi6t87YB3MArNZJV49msAIUiQsYCvxf5cLiMkioCpx
        9JgdyAJeAWeJcyfXsEMsk5O4ea4TbCSngIvE6j1gJUJAJftaOhknMPIsYGRYxSiSWlqcm55b
        bKRXnJhbXJqXrpecn7uJERj024793LKDsetd8CFGAQ5GJR5egwjeaCHWxLLiytxDjBIczEoi
        vKV7eaKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8543qIwSEkhPLEnNTk0tSC2CyTJxcEo1MC6P
        21tgcniaznezjh+rp0QLmBtffLNRWt0w0X+qa4vBzLfpYTHNOq+C1n3/3ZmYIVY7xXeT1Usu
        ZRWbFeb1so/1jYoOaepETpvft0aaac4G9bq/2XUTtVbYrTMNbpOfpsb5gG+63O2i3gMPazsb
        RfMKt613+s7bYvL2VlFB1cNivzjeIvbLSizFGYmGWsxFxYkAouk7QnYCAAA=
X-CMS-MailID: 20180530121626eucas1p288656bbbace0c333decadff418e13c34
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121626eucas1p288656bbbace0c333decadff418e13c34
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121626eucas1p288656bbbace0c333decadff418e13c34@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds bindings to BOE HV070-WSA WSVGA panel.
Bindings are compatible with simple panel bindings.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 .../devicetree/bindings/display/panel/boe,hv070wsa-100.txt         | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt

diff --git a/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
new file mode 100644
index 0000000..bfc20ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
@@ -0,0 +1,7 @@
+BOE HV070WSA-100 7.01" WSVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "boe,hv070wsa-100"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.7.4

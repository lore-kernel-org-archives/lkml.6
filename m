Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbeE3MQz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:16:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34173 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeE3MQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:16:33 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180530121631euoutp024eb599ec148fdcd321f56d4ef5b200a7~zazkV3Lkr0061000610euoutp02W
X-AuditID: cbfec7f4-b4fc79c0000043e4-86-5b0e961cd64e
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
Subject: [PATCH v2 07/10] dt-bindings: tc358754: add DT bindings
Date: Wed, 30 May 2018 14:15:58 +0200
Message-id: <1527682561-1386-8-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe8/Z2ZnL2WlavukyGIQlZZqhLyimuODQl/xWKKUzDyrplB1v
        i8pLWHMy87LlUlHLS95Sm8sbanihFaZLLC8LtTBMm9YHNRJCc259+73/58fzPg88PFyYR7jx
        EmSpjFwmTRRz+ZyuN9ums6LHTpE+jeNByNw2QSD1xDsM5SrXCfRS106g6tG97OPWLy4qWSzi
        oJWFSQ56tGTBkcnUQaLx3DUS5RfXkUi/NE2gqb5KLtKZBjFUs2rmoBej8ySqn5nEUN7AKIl0
        patctN1XxQk5QrdWtQJ6qlCN0b3l8yRdoXxC0PrmfC7d/fsLQS8WGDG6sy6LLjQ0A3pD7xHO
        j+AHxTKJCemM/FxwND9eM7IMUvIOZc7sLJHZoN9RBRx4kLoAe9rUhJWFVCOAA5/EKsDf4w0A
        NSNfSRXg7UvPNt1teQOAFZ81wPbYBVDbOwSsEpfygq0Po6y5C9UMYOfs+r6EU1oCfqi27H/h
        TIXASuMQbmUOdRKaR3SYlQVUGKxdbMdsI3nAuYl83NrUgZLAlv5gax9IlZLwp1prdyRwqnqY
        a2Nn+MNoIG0sgvnKIbuTDPOWl+x5JhxUjxE2DoQjxsl9xiknWNJVhtu2FEDlA6FNoWGTtsW+
        ZBmA+nUTKALHasCBZuDKpLFJcQx7XsZkeLPSJDZNFud9MzlJD/aOY2zHuNkD+v7GDAOKB8SO
        Ap9rgkghIU1nFUnDAPJwsYsgbcAxUiiIlSpuM/LkKHlaIsMOA3ceR+wquHHqXoSQipOmMrcY
        JoWR/69iPAe3bKD4UzCnsuRqOtZhaUXv4VcSVjVz8MyVnYur9y3Rnu/H39Y/DQlayMy5Exhe
        16SOCbVk+U9n7Hb71t5t8zxuMm/5aQ2ytXqQsyL65l9V7HOiNuf0pYbvBrTh1xGQkl0Y4CVd
        xYhy5VWT32sXn8uzVc9DryuKJYGio1lRFTXGsBIxh42X+nrhclb6DyDFdJIYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t/xy7rS0/iiDfoP6lrcWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLSfcnsFi8uHeRxaL/8Wtmi/PnN7BbnG16w27ROXEJu8Wm
        x9dYLS7vmsNmMeP8PiaLBS9vsVisPXKX3WLp9YtMFq17j7BbzJj8ks3i5655LA6iHmvmrWH0
        uNzXy+Sxc9Zddo/ZHTNZPTat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAFcUl01Kak5m
        WWqRvl0CV8aUw88YC1r5K67/e8zewLiHp4uRg0NCwERi0RfpLkYuDiGBJYwSa04eZYNwGpkk
        5nxczAJSxCagJbGmPR4kLiKwilFi6t877CAOs8BsVolXjyYwdjFycggLOEjMOX6QGcRmEVCV
        uHV4BhOIzSvgLLH4/nowW0JATuLmuU5mkKGcAi4Sq/fYgYSFgEr2tXQyTmDkWcDIsIpRJLW0
        ODc9t9hQrzgxt7g0L10vOT93EyMw7Lcd+7l5B+OljcGHGAU4GJV4eA0ieKOFWBPLiitzDzFK
        cDArifCW7uWJFuJNSaysSi3Kjy8qzUktPsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp
        1cA4Y+rOafLM+SVnreWKb2gcK540rTXatue8iuY/vv8dMXMCjRe5vnrkwypd/dPIyvPD4869
        v1YIT2RVW2gWUWLr1bDjX2SCT2v5hOWzlNXrsgtb1sZuSrI5Pu1Uo4C41sk9M2M4Gg8riNQ8
        3V+wbcHdV3HW3tILDp5+VCVhkFG42vDfjIPHEtmVWIozEg21mIuKEwETYAkwdwIAAA==
X-CMS-MailID: 20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
Bindings describe power supplies, reset gpio and video interfaces.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 .../bindings/display/bridge/toshiba,tc358764.txt   | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
new file mode 100644
index 0000000..6eda14f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
@@ -0,0 +1,37 @@
+TC358764 MIPI-DSI to LVDS panel bridge
+
+Required properties:
+  - compatible: "toshiba,tc358764"
+  - reg: the virtual channel number of a DSI peripheral
+  - vddc-supply: core voltage supply, 1.2V
+  - vddio-supply: I/O voltage supply, 1.8V or 3.3V
+  - vddlvds-supply: LVDS1/2 voltage supply, 3.3V
+  - reset-gpios: a GPIO spec for the reset pin
+
+The device node can contain zero to two 'port' child nodes, each with one
+child 'endpoint' node, according to the bindings defined in [1].
+The following are properties specific to those nodes.
+
+port:
+  - reg: (required) can be 0 for DSI port or 1 for LVDS port;
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+	bridge@0 {
+		reg = <0>;
+		compatible = "toshiba,tc358764";
+		vddc-supply = <&vcc_1v2_reg>;
+		vddio-supply = <&vcc_1v8_reg>;
+		vddlvds-supply = <&vcc_3v3_reg>;
+		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port@1 {
+			reg = <1>;
+			lvds_ep: endpoint {
+				remote-endpoint = <&panel_ep>;
+			};
+		};
+	};
-- 
2.7.4

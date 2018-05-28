Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932250AbeE1Jry (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:47:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40591 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754305AbeE1Jrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:47:32 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180528094730euoutp023b40048792410a09544c243b7f1cf42f~yxe4XVklx1452514525euoutp02Q
X-AuditID: cbfec7f5-b45ff700000028a9-05-5b0bd030c1b2
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
Subject: [PATCH 07/12] dt-bindings: tc358754: add DT bindings
Date: Mon, 28 May 2018 11:47:11 +0200
Message-id: <1527500833-16005-8-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSaUhUURiGO3d3bPIyWp5MFAaCEDStxANm9cPoElTSr1BQp7y55KjMdUyF
        cjdHcY10StERl8Q0dRTHBcVMmsRcBkPTcAFNXAsULTG1uY3+e97nvHyHDz4Gl2WSDkx4VCyv
        ilJEyikJ0f5pd9TVfcw6wH1q3hlNvx8hUe7IIIZSszZI1KJtIlHFgNl93f5FoaK5AgItz5oI
        lL+whqPR0WYaDaeu00hTWE0j/cIEica7yiikHe3FkG5lmkCNAzM0qpk0YSijZ4BG2pcrFNrt
        KidunOYayhsAN56Xi3Gdb2ZorjTrNcnp6zUUZ9iZJ7m5HCPGtVYncXlt9YDb0jv5SfwlV0P4
        yPA4XnXxWrAkrG8yG4vZsonv3dukkkGJNBtYMZC9Avdnh4HIMrYOwJIuVwtvAThRqz7ufD5M
        IbKBxOxrAazbqzoKhwAWlX43B4ahWBfY8CJI9HZsPYCt3zaAGHD2FQnHKtZIcZQt6wPLUlYx
        kQn2PNwvSKdFlrK+cFA3SVm+c4JTIxpcZCv2JhzvyaTEQZDNp2GPpgK3lHxhcU0ZaWFbuGps
        oy3sCDVZHzALR8OMpYUjHw97c4eO+t7wo9H0n3H2FCxqL8HFDSArhVmZMkuFg936LsyypRbA
        hR8doACc1YET9cCeVwvKUF64HMU/dRMUSkEdFer2KFqpB+brGDowbneA3r8P+wHLAPlJafKe
        JEBGKuKEBGU/gAwut5NKXM1KGqJISORV0UEqdSQv9INzDCG3lwZeeO4vY0MVsfwTno/hVcev
        GGPlkAwSHod5bw7ZLBanBa7rrzfr7nfE67RE5rDVg6BbylNnmrysBw9++92JKH/r/DOh8JJn
        StI9x5wCeWKbWh1pKsuvdBv3annm3GmsjlF5Nm6s73SzPoMx75bwypUDITiWLDH8SWot/mKY
        SmvEqdW7Qt/yYtXtbaPHkjwiPYRNNpjkhBCm8HDBVYLiH86N+20ZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xy7r6F7ijDR6dN7G4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErowD17uYCj7zV+z7/YmtgXE6bxcjJ4eEgInEif+NLF2MXBxCAksYJR7ffsMI4TQy
        SXxf/I25i5GDg01AS2JNezxIXERgFaPE1L932EEcZoHZrBKvHk1gBBklLGArMafxFROIzSKg
        KvF3Qgs7iM0r4CJxcsF1Noh1chI3z3Uyg9icAq4Sl/e2gcWFgGq2N85imcDIs4CRYRWjSGpp
        cW56brGhXnFibnFpXrpecn7uJkZg6G879nPzDsZLG4MPMQpwMCrx8Db85ooWYk0sK67MPcQo
        wcGsJMLLpQsU4k1JrKxKLcqPLyrNSS0+xCjNwaIkznveoDJKSCA9sSQ1OzW1ILUIJsvEwSnV
        wBj27U9TZXGK7mRO7sybmUeO9UfNklVU0n3345SKeadf0RmRJevyH/w9XtZ+8MjMG3OKkpl7
        /FJuKtdcXmR00kfXcP0ZxgmnOnVqfrk2Xbg+W+65xo0TGilJfsqX5y8x7NPm+LBB0UXrSEJK
        j9Ox2VruIqfue0kHHd2t/Jy3b/JF563nFdqjA5VYijMSDbWYi4oTAWL/2bt5AgAA
X-CMS-MailID: 20180528094727eucas1p153b8116120cd2195b15b74776f171cbe
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528094727eucas1p153b8116120cd2195b15b74776f171cbe
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528094727eucas1p153b8116120cd2195b15b74776f171cbe@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
Bindings describe power supplies, reset gpio and video interfaces.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 .../bindings/display/bridge/toshiba,tc358764.txt   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
new file mode 100644
index 0000000..d09bdc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
@@ -0,0 +1,42 @@
+TC358764 MIPI-DSI to LVDS panel bridge
+
+Required properties:
+  - compatible: "toshiba,tc358764"
+  - reg: the virtual channel number of a DSI peripheral
+  - vddc-supply: core voltage supply
+  - vddio-supply: I/O voltage supply
+  - vddmipi-supply: MIPI voltage supply
+  - vddlvds133-supply: LVDS1 3.3V voltage supply
+  - vddlvds112-supply: LVDS1 1.2V voltage supply
+  - reset-gpios: a GPIO spec for the reset pin
+
+The device node can contain zero to two 'port' child nodes, each with one
+child
+'endpoint' node, according to the bindings defined in [1].
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
+		vddmipi-supply = <&vcc_1v2_reg>;
+		vddlvds133-supply = <&vcc_3v3_reg>;
+		vddlvds112-supply = <&vcc_1v2_reg>;
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

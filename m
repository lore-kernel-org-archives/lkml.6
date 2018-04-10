Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeDJFUQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:20:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:65223 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751778AbeDJFUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:20:13 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 1/2] dt-bindings/display/bridge: sii902x: add optional power supplies
Date: Tue, 10 Apr 2018 07:19:26 +0200
Message-ID: <20180410051927.8268-2-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180410051927.8268-1-philippe.cornu@st.com>
References: <20180410051927.8268-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.58]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 3 optional power supplies using the exact description
found in the document named
"SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 Documentation/devicetree/bindings/display/bridge/sii902x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
index 56a3e68ccb80..cf53678fe574 100644
--- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
+++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
@@ -8,6 +8,9 @@ Optional properties:
 	- interrupts-extended or interrupt-parent + interrupts: describe
 	  the interrupt line used to inform the host about hotplug events.
 	- reset-gpios: OF device-tree gpio specification for RST_N pin.
+	- iovcc-supply: I/O supply voltage (1.8V or 3.3V, host-dependent).
+	- avcc12-supply: TMDS analog supply voltage (1.2V).
+	- cvcc12-supply: Digital core supply voltage (1.2V).
 
 Optional subnodes:
 	- video input: this subnode can contain a video input port node
-- 
2.15.1

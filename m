Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756595AbeDXHyv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:54:51 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15024 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756072AbeDXHyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:54:41 -0400
From: yannick fertre <yannick.fertre@st.com>
To: Philippe Cornu <philippe.cornu@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        "Gerald Baeza" <gerald.baeza@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        "Kamel Kholti" <kamel.kholti@st.com>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v1 3/3] ARM: dts: stm32: add cec support on stm32mp157c-ev1
Date: Tue, 24 Apr 2018 09:54:09 +0200
Message-ID: <1524556449-5262-4-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524556449-5262-1-git-send-email-yannick.fertre@st.com>
References: <1524556449-5262-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables cec node on stm32mp157c-ev1 board

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 57e6dbc..e2a583b 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -19,3 +19,9 @@
 		serial0 = &uart4;
 	};
 };
+
+&cec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cec_pins_a>;
+	status = "okay";
+};
-- 
1.9.1

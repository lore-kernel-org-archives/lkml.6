Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756627AbeDXHzM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:55:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29782 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756604AbeDXHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:55:09 -0400
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
Subject: [PATCH v1 0/2] Add ltdc & dsi support on stm32mp157c
Date: Tue, 24 Apr 2018 09:54:46 +0200
Message-ID: <1524556488-5404-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds display controller & DSI controller support to 
stm32mp157c SOC.

Version 1:
- Initial commit

yannick fertre (2):
  ARM: dts: stm32: add ltdc support on stm32mp157c
  ARM: dts: stm32: add dsi support on stm32mp157c

 arch/arm/boot/dts/stm32mp157c.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
1.9.1

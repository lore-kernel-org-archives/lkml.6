Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756343AbeDXHyg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:54:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28353 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755504AbeDXHyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:54:32 -0400
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
Subject: [PATCH v1 0/3] Enable CEC on stm32mp157c-ev1 board
Date: Tue, 24 Apr 2018 09:54:06 +0200
Message-ID: <1524556449-5262-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set enables CEC (Consumer Electronics Control) on stm32mp157c
eval board.

yannick fertre (3):
  ARM: dts: stm32: add cec support on stm32mp157c
  ARM: dts: stm32: add cec pins to stm32mp157c
  ARM: dts: stm32: add cec support on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 9 +++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 6 ++++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 9 +++++++++
 3 files changed, 24 insertions(+)

-- 
1.9.1

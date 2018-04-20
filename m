Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755974AbeDTP5I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:57:08 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49784 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755837AbeDTP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:57:06 -0400
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH 0/5] ARM: dts: STi: Fix complain about IRQ_TYPE_NONE_usage 
Date: Fri, 20 Apr 2018 17:54:39 +0200
Message-ID: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG3NODE4.st.com (10.75.127.71) To GPXDAG6NODE6.st.com
 (10.75.127.82)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Fix the STi following DT files which make usage of IRQ_TYPE_NONE flag:
 _ stih407-family.dtsi
 _ stih407-pinctrl.dtsi
 _ stih407.dtsi
 _ stih410.dtsi
 _ stihxxx-b2120.dtsi  

Patrice Chotard (5):
  ARM: dts: stih407-family: Fix complain about IRQ_TYPE_NONE usage
  ARM: dts: stih407-pinctrl: Fix complain about IRQ_TYPE_NONE usage
  ARM: dts: stih407: Fix complain about IRQ_TYPE_NONE usage
  ARM: dts: stih410: Fix complain about IRQ_TYPE_NONE usage
  ARM: dts: stihxxx-b2120: Fix complain about IRQ_TYPE_NONE usage

 arch/arm/boot/dts/stih407-family.dtsi  | 52 +++++++++++++++++-----------------
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 10 +++----
 arch/arm/boot/dts/stih407.dtsi         |  2 +-
 arch/arm/boot/dts/stih410.dtsi         | 18 ++++++------
 arch/arm/boot/dts/stihxxx-b2120.dtsi   |  4 +--
 5 files changed, 43 insertions(+), 43 deletions(-)

-- 
1.9.1

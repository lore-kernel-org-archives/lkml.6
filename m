Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964821AbeEYHsl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:48:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22110 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935884AbeEYHrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:47:32 -0400
From: Christophe Roullier <christophe.roullier@st.com>
To: <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <peppe.cavallaro@st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <netdev@vger.kernel.org>, <robh@kernel.org>,
        <christophe.roullier@st.com>
Subject: [PATCH V0:net-next 0/4] net: ethernet: stmmac: add support for stm32mp1
Date: Fri, 25 May 2018 09:46:37 +0200
Message-ID: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches to have Ethernet support on stm32mp1

Christophe Roullier (4):
  net: ethernet: stmmac: add adaptation for stm32mp157c.
  dt-bindings: stm32-dwmac: add support of MPU families
  net: stmmac: add dwmac-4.20a compatible
  dt-bindings: stm32: add compatible for syscon

 .../devicetree/bindings/arm/stm32/stm32-syscon.txt |  14 ++
 .../devicetree/bindings/arm/{ => stm32}/stm32.txt  |   0
 .../devicetree/bindings/net/stm32-dwmac.txt        |  18 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  | 267 +++++++++++++++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   3 +-
 5 files changed, 284 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
 rename Documentation/devicetree/bindings/arm/{ => stm32}/stm32.txt (100%)

-- 
1.9.1

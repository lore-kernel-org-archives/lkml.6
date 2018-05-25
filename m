Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935972AbeEYHre (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:47:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16058 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935619AbeEYHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:47:31 -0400
From: Christophe Roullier <christophe.roullier@st.com>
To: <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <peppe.cavallaro@st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <netdev@vger.kernel.org>, <robh@kernel.org>,
        <christophe.roullier@st.com>
Subject: [PATCH V0:net-next 3/4] net: stmmac: add dwmac-4.20a compatible
Date: Fri, 25 May 2018 09:46:40 +0200
Message-ID: <1527234401-15812-4-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
References: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manage dwmac-4.20a version from synopsys

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index ebd3e5f..6d141f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -472,7 +472,8 @@ struct plat_stmmacenet_data *
 	}
 
 	if (of_device_is_compatible(np, "snps,dwmac-4.00") ||
-	    of_device_is_compatible(np, "snps,dwmac-4.10a")) {
+	    of_device_is_compatible(np, "snps,dwmac-4.10a") ||
+	    of_device_is_compatible(np, "snps,dwmac-4.20a")) {
 		plat->has_gmac4 = 1;
 		plat->has_gmac = 0;
 		plat->pmt = 1;
-- 
1.9.1

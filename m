Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeBJDti (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 22:49:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750832AbeBJDtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 22:49:36 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
        hbabu@us.ibm.com, linuxppc-dev@ozlabs.org,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 3/4] powerpc/vas: Remove a stray line in Makefile
Date: Fri,  9 Feb 2018 19:49:26 -0800
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021003-0048-0000-0000-000002354ECF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008507; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000251; SDB=6.00987496; UDB=6.00501245; IPR=6.00766855;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019472; XFM=3.00000015;
 UTC=2018-02-10 03:49:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021003-0049-0000-0000-00004413EE65
Message-Id: <1518234567-24869-3-git-send-email-sukadev@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802100047
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a bogus line from arch/powerpc/platforms/powernv/Makefile that
was added by commit ece4e51 ("powerpc/vas: Export HVWC to debugfs").

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 6c9d519..703a350 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -16,5 +16,4 @@ obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
 obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
 obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o
-obj-$(CONFIG_PPC_FTW)	+= nx-ftw.o
 obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
-- 
2.7.4

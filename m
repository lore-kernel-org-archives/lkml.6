Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754414AbeE1Nsj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:48:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751238AbeE1Nsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:48:30 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Use header file util/debug.h
Date: Mon, 28 May 2018 15:48:17 +0200
X-Mailer: git-send-email 2.16.3
X-TM-AS-GCONF: 00
x-cbid: 18052813-0040-0000-0000-0000043E9836
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052813-0041-0000-0000-00002643E388
Message-Id: <20180528134817.36643-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the header file util/debug.h instead of
declaration of verbose variable.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/python-use.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 5d2df65ada6a..40ab72149ce1 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -7,8 +7,7 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include "tests.h"
-
-extern int verbose;
+#include "util/debug.h"
 
 int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-- 
2.14.3

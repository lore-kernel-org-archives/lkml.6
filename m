Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeE1Htu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:49:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753734AbeE1Htr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:49:47 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf docu: Update section on cpu description
Date: Mon, 28 May 2018 09:49:03 +0200
X-Mailer: git-send-email 2.16.3
X-TM-AS-GCONF: 00
x-cbid: 18052807-0020-0000-0000-00000421E1C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052807-0021-0000-0000-000042B73139
Message-Id: <20180528074903.21781-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280097
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the section HEADER_CPUDESC so the documentation
matches code.  Swap the two members of struct nr_cpus.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index d00f0d51cab8..16e2da0b674c 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -111,8 +111,8 @@ A perf_header_string with the CPU architecture (uname -m)
 A structure defining the number of CPUs.
 
 struct nr_cpus {
-       uint32_t nr_cpus_online;
        uint32_t nr_cpus_available; /* CPUs not yet onlined */
+       uint32_t nr_cpus_online;
 };
 
 	HEADER_CPUDESC = 8,
-- 
2.14.3

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeA3F31 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 00:29:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752232AbeA3F3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 00:29:24 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 1/2] perf tools: Add trace/beauty/generated/ into .gitignore
Date: Tue, 30 Jan 2018 11:00:52 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180130053053.13214-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180130053053.13214-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18013005-0040-0000-0000-0000040A3E3D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013005-0041-0000-0000-0000260DD495
Message-Id: <20180130053053.13214-2-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801300071
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functionality changes.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 643cc4ba..3e5135d 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -31,5 +31,6 @@ config.mak.autogen
 .config-detected
 util/intel-pt-decoder/inat-tables.c
 arch/*/include/generated/
+trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
-- 
1.8.3.1

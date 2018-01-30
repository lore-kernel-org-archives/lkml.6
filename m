Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeA3F3W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 00:29:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752232AbeA3F3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 00:29:21 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 0/2] perf trace: Two trivial fixes
Date: Tue, 30 Jan 2018 11:00:51 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18013005-0016-0000-0000-0000051D43E6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013005-0017-0000-0000-00002859DEB8
Message-Id: <20180130053053.13214-1-ravi.bangoria@linux.vnet.ibm.com>
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

Two independent fixes:
First adds 'generated' directory into .gitignore
Second fixes call-graph output with perf trace

Ravi Bangoria (2):
  perf tools: Add trace/beauty/generated/ into .gitignore
  perf trace: Fix call-graph output

 tools/perf/.gitignore      | 1 +
 tools/perf/builtin-trace.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
1.8.3.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeDQEOB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:14:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752085AbeDQEN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:13:59 -0400
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mhiramat@kernel.org, jolsa@redhat.com, acme@redhat.com
Cc: kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] perf/buildid-cache: Add --list and --purge-all options
Date: Tue, 17 Apr 2018 09:43:43 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18041704-0044-0000-0000-00000548FF81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041704-0045-0000-0000-000028890AC0
Message-Id: <20180417041346.5617-1-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170038
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch is a trivial error message fix. Second and third
adds new options --list and --purge-all to 'buildid-cache'
subcommand.

v2 changes:
 - [PATCH v2 2/3] Display optput of 'perf buildid-cache -l' same as
   'perf buildid-list'.
 - [PATCH v2 2/3] Other minor changes as suggested by Jiri.

v1 can be found at:
  https://lkml.org/lkml/2018/4/9/295

Ravi Bangoria (3):
  tools/parse-options: Add '\n' at the end of error messages
  perf/buildid-cache: Support --list option
  perf/buildid-cache: Support --purge-all option

 tools/lib/subcmd/parse-options.c                |  6 +-
 tools/perf/Documentation/perf-buildid-cache.txt |  7 ++-
 tools/perf/builtin-buildid-cache.c              | 77 ++++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 7 deletions(-)

-- 
2.14.3

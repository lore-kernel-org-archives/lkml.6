Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeDILGz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:06:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750952AbeDILGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:06:53 -0400
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@redhat.com
Cc: mhiramat@kernel.org, kstewart@linuxfoundation.org, tglx@linutronix.de,
        pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, uneedsihyeon@gmail.com, kjlx@templeofstupid.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 0/3] perf/buildid-cache: Add --list and --purge-all options
Date: Mon,  9 Apr 2018 16:36:30 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18040911-0020-0000-0000-0000040FA975
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040911-0021-0000-0000-000042A3C9BF
Message-Id: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch is a trivial error message fix. Second and third
adds new options --list and --purge-all to 'buildid-cache'
subcommand.

Ravi Bangoria (3):
  tools/parse-options: Add '\n' at the end of error messages
  perf/buildid-cache: Support --list option
  perf/buildid-cache: Support --purge-all option

 tools/lib/subcmd/parse-options.c                |  6 +-
 tools/perf/Documentation/perf-buildid-cache.txt |  7 ++-
 tools/perf/builtin-buildid-cache.c              | 75 ++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 7 deletions(-)

-- 
2.14.3

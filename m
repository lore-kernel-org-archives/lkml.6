Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932776AbeCMWqy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:46:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932197AbeCMWqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:46:53 -0400
Date: Tue, 13 Mar 2018 15:46:47 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull JSON files for POWR9 PMU events
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.7.1 (2016-10-04)
X-TM-AS-GCONF: 00
x-cbid: 18031322-0020-0000-0000-00000D964481
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008668; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002637; UDB=6.00510192; IPR=6.00781967;
 MB=3.00020016; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-13 22:46:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031322-0021-0000-0000-0000607BB00A
Message-Id: <20180313224647.GA22960@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130250
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arnaldo,

Please pull an update to the JSON files for POWER9 PMU events.

The following changes since commit 90d2614c4d10c2f9d0ada9a3b01e5f43ca8d1ae3:

  perf test: Fix exit code for record+probe_libc_inet_pton.sh (2018-03-13 15:14:43 -0300)

are available in the git repository at:

  https://github.com/sukadev/linux/ p9-json-v5

for you to fetch changes up to 99c9dff949f2502964005f9afa8d60c89b446f2c:

  perf vendor events: Update POWER9 events (2018-03-13 16:48:12 -0500)

----------------------------------------------------------------
Sukadev Bhattiprolu (1):
      perf vendor events: Update POWER9 events

 .../perf/pmu-events/arch/powerpc/power9/cache.json |  25 ---
 .../pmu-events/arch/powerpc/power9/frontend.json   |  10 -
 .../pmu-events/arch/powerpc/power9/marked.json     |   5 -
 .../pmu-events/arch/powerpc/power9/memory.json     |   5 -
 .../perf/pmu-events/arch/powerpc/power9/other.json | 241 ++++++++++++++-------
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  50 ++---
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   5 -
 .../arch/powerpc/power9/translation.json           |  10 +-
 8 files changed, 178 insertions(+), 173 deletions(-)

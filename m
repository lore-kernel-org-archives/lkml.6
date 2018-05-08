Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754519AbeEHHCX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:02:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754425AbeEHHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:02:20 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 0/3] docs/vm: move numa_memory_policy.rst to admin-guide/mm
Date: Tue,  8 May 2018 10:02:07 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18050807-0008-0000-0000-000004F43B6F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050807-0009-0000-0000-00001E887AF9
Message-Id: <1525762930-28163-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080069
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches include minor formatting and spelling updates to
Documentation/vm/numa_memory_policy.rst and move this file to
Documentation/admin-guide/mm.

Mike Rapoport (3):
  docs/vm: numa_memory_policy: formatting and spelling updates
  docs/vm: numa_memory_policy: s/Linux memory policy/NUMA memory policy/
  docs/vm: move numa_memory_policy.rst to Documentation/admin-guide/mm

 Documentation/admin-guide/mm/hugetlbpage.rst       |  2 +-
 Documentation/admin-guide/mm/index.rst             |  1 +
 .../{vm => admin-guide/mm}/numa_memory_policy.rst  | 38 ++++++++++++++--------
 Documentation/filesystems/proc.txt                 |  2 +-
 Documentation/filesystems/tmpfs.txt                |  5 +--
 Documentation/vm/00-INDEX                          |  2 --
 Documentation/vm/index.rst                         |  1 -
 Documentation/vm/numa.rst                          |  2 +-
 8 files changed, 31 insertions(+), 22 deletions(-)
 rename Documentation/{vm => admin-guide/mm}/numa_memory_policy.rst (95%)

-- 
2.7.4

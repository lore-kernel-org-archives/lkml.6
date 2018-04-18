Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeDRIID (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:08:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752310AbeDRIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:08:00 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 0/7]  docs/vm: start moving files do Documentation/admin-guide`
Date: Wed, 18 Apr 2018 11:07:43 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18041808-0040-0000-0000-000004304172
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041808-0041-0000-0000-0000263450A3
Message-Id: <1524038870-413-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180076
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These pacthes begin categorizing memory management documentation.  The
documents that describe userspace APIs and do not overload the reader with
implementation details can be moved to Documentation/admin-guide, so let's
do it :)

Mike Rapoport (7):
  docs/vm: hugetlbpage: minor improvements
  docs/vm: hugetlbpage: move section about kernel development to
    hugetlbfs_reserv
  docs/vm: pagemap: formatting and spelling updates
  docs/vm: pagemap: change document title
  docs/admin-guide: introduce basic index for mm documentation
  docs/admin-guide/mm: start moving here files from Documentation/vm
  docs/admin-guide/mm: convert plain text cross references to hyperlinks

 Documentation/ABI/stable/sysfs-devices-node        |  2 +-
 .../ABI/testing/sysfs-kernel-mm-hugepages          |  2 +-
 Documentation/admin-guide/index.rst                |  1 +
 .../{vm => admin-guide/mm}/hugetlbpage.rst         | 28 +++++++--------
 .../{vm => admin-guide/mm}/idle_page_tracking.rst  |  5 +--
 Documentation/admin-guide/mm/index.rst             | 28 +++++++++++++++
 Documentation/{vm => admin-guide/mm}/pagemap.rst   | 40 ++++++++++++----------
 .../{vm => admin-guide/mm}/soft-dirty.rst          |  0
 .../{vm => admin-guide/mm}/userfaultfd.rst         |  0
 Documentation/filesystems/proc.txt                 |  6 ++--
 Documentation/sysctl/vm.txt                        |  4 +--
 Documentation/vm/00-INDEX                          | 10 ------
 Documentation/vm/hugetlbfs_reserv.rst              |  8 +++++
 Documentation/vm/hwpoison.rst                      |  2 +-
 Documentation/vm/index.rst                         |  5 ---
 fs/Kconfig                                         |  2 +-
 fs/proc/task_mmu.c                                 |  4 +--
 mm/Kconfig                                         |  5 +--
 18 files changed, 89 insertions(+), 63 deletions(-)
 rename Documentation/{vm => admin-guide/mm}/hugetlbpage.rst (95%)
 rename Documentation/{vm => admin-guide/mm}/idle_page_tracking.rst (96%)
 create mode 100644 Documentation/admin-guide/mm/index.rst
 rename Documentation/{vm => admin-guide/mm}/pagemap.rst (83%)
 rename Documentation/{vm => admin-guide/mm}/soft-dirty.rst (100%)
 rename Documentation/{vm => admin-guide/mm}/userfaultfd.rst (100%)

-- 
2.7.4

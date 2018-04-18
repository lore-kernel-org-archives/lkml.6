Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDRIIU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:08:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753279AbeDRIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:08:16 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 5/7] docs/admin-guide: introduce basic index for mm documentation
Date: Wed, 18 Apr 2018 11:07:48 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524038870-413-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524038870-413-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041808-0012-0000-0000-000005CC1E27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041808-0013-0000-0000-000019486DB1
Message-Id: <1524038870-413-6-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180076
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/admin-guide/index.rst    |  1 +
 Documentation/admin-guide/mm/index.rst | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/index.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 5bb9161..cac906f 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -63,6 +63,7 @@ configure specific aspects of kernel behavior to your liking.
    pm/index
    thunderbolt
    LSM/index
+   mm/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
new file mode 100644
index 0000000..c47c16e
--- /dev/null
+++ b/Documentation/admin-guide/mm/index.rst
@@ -0,0 +1,19 @@
+=================
+Memory Management
+=================
+
+Linux memory management subsystem is responsible, as the name implies,
+for managing the memory in the system. This includes implemnetation of
+virtual memory and demand paging, memory allocation both for kernel
+internal structures and user space programms, mapping of files into
+processes address space and many other cool things.
+
+Linux memory management is a complex system with many configurable
+settings. Most of these settings are available via ``/proc``
+filesystem and can be quired and adjusted using ``sysctl``. These APIs
+are described in Documentation/sysctl/vm.txt and in `man 5 proc`_.
+
+.. _man 5 proc: http://man7.org/linux/man-pages/man5/proc.5.html
+
+Here we document in detail how to interact with various mechanisms in
+the Linux memory management.
-- 
2.7.4

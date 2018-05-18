Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeERWxC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:53:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbeERWxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:53:00 -0400
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadia Yvette Chambers <nyc@holomorphy.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Jan Kara <jack@suse.cz>, Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] MAINTAINERS: Change hugetlbfs maintainer and update files
Date: Fri, 18 May 2018 15:52:36 -0700
Message-Id: <20180518225236.19079-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=839
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180240
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current hugetlbfs maintainer has not been active for more than
a few years.  I have been been active in this area for more than
two years and plan to remain active in the foreseeable future.

Also, update the hugetlbfs entry to include linux-mm mail list and
additional hugetlbfs related files.  hugetlb.c and hugetlb.h are
not 100% hugetlbfs, but a majority of their content is hugetlbfs
related.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 MAINTAINERS | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9051a9ca24a2..c7a5eb074eb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6564,9 +6564,15 @@ F:	Documentation/networking/hinic.txt
 F:	drivers/net/ethernet/huawei/hinic/
 
 HUGETLB FILESYSTEM
-M:	Nadia Yvette Chambers <nyc@holomorphy.com>
+M:	Mike Kravetz <mike.kravetz@oracle.com>
+L:	linux-mm@kvack.org
 S:	Maintained
 F:	fs/hugetlbfs/
+F:	mm/hugetlb.c
+F:	include/linux/hugetlb.h
+F:	Documentation/admin-guide/mm/hugetlbpage.rst
+F:	Documentation/vm/hugetlbfs_reserv.rst
+F:	Documentation/ABI/testing/sysfs-kernel-mm-hugepages
 
 HVA ST MEDIA DRIVER
 M:	Jean-Christophe Trotin <jean-christophe.trotin@st.com>
-- 
2.13.6

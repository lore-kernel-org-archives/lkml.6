Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756411AbeDXGmD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:42:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755999AbeDXGmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:42:00 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 0/2] mm/ksm: minor cleanups
Date: Tue, 24 Apr 2018 09:41:44 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18042406-0020-0000-0000-0000041527D9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042406-0021-0000-0000-000042A98887
Message-Id: <1524552106-7356-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While working on KSM docs, I've noticed some minor points which are
addressed by the below patches.

Mike Rapoport (2):
  mm/ksm: remove unused page_referenced_ksm declaration
  mm/ksm: move [set_]page_stable_node from ksm.h to ksm.c

 include/linux/ksm.h | 17 -----------------
 mm/ksm.c            | 12 ++++++++++++
 2 files changed, 12 insertions(+), 17 deletions(-)

-- 
2.7.4

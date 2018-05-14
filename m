Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeENINy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:13:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752669AbeENINv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:13:51 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 0/3] docs/vm: transhuge: split userspace bits to admin-guide/mm 
Date: Mon, 14 May 2018 11:13:37 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18051408-0012-0000-0000-000005D652AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051408-0013-0000-0000-000019536692
Message-Id: <1526285620-453-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are minor updates to transparent hugepage docs. Except from minor
formatting and spelling updates, these patches re-arrange the transhuge.rst
so that userspace interface description will not be interleaved with the
implementation details and it would be possible to split the userspace
related bits to Documentation/admin-guide/mm, which is done by the third
patch.

Mike Rapoport (3):
  docs/vm: transhuge: change sections order
  docs/vm: transhuge: minor updates
  docs/vm: transhuge: split userspace bits to admin-guide/mm/transhuge

 Documentation/admin-guide/kernel-parameters.txt |   3 +-
 Documentation/admin-guide/mm/index.rst          |   1 +
 Documentation/admin-guide/mm/transhuge.rst      | 418 ++++++++++++++++++++++++
 Documentation/vm/transhuge.rst                  | 395 +---------------------
 4 files changed, 426 insertions(+), 391 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/transhuge.rst

-- 
2.7.4

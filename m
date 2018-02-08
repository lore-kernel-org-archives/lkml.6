Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeBHSfJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:35:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752197AbeBHSfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:35:08 -0500
Subject: [GIT PULL] IMA bug fixes for 4.16-rc1
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: inux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 08 Feb 2018 13:35:01 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020818-0008-0000-0000-000004CADF07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020818-0009-0000-0000-00001E5E93EF
Message-Id: <1518114901.3445.3.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Here are the remaining 2 FUSE patches.

thanks,

Mimi

The following changes since commit e2598077dc6a26c9644393e5c21f22a90dbdccdb:

  ima: re-initialize iint->atomic_flags (2018-02-02 21:03:08 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git fixes-v4.16-rc1

for you to fetch changes up to f132f946073b19687a2d52888e4a4f9b2d46478e:

  fuse: introduce new fs_type flag FS_IMA_NO_CACHE (2018-02-08 10:59:03 -0500)

----------------------------------------------------------------
Alban Crequy (2):
      ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE
      fuse: introduce new fs_type flag FS_IMA_NO_CACHE

 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/ima/ima_main.c | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

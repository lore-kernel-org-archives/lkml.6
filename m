Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeBASiQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:38:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752695AbeBASiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:38:10 -0500
Subject: [GIT PULL] IMA bug fixes for 4.16
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 01 Feb 2018 13:38:02 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020118-0020-0000-0000-000003F1618E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020118-0021-0000-0000-00004283CC0B
Message-Id: <1517510282.6675.13.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802010238
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Included in this pull request are three bug fixes, assuming the 2 FUSE
patches are considered bugs and not new features, and a maintainer update.
I'd appreciate your sending them to Linus for 4.16.

thanks,

Mimi

The following changes since commit 36447456e1cca853188505f2a964dbbeacfc7a7a:

  ima/policy: fix parsing of fsuuid (2018-01-18 16:52:49 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to d56f30ac85c067d0d3a6c4f293f655dc298cb5ce:

  ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE (2018-02-01 12:38:31 -0500)

----------------------------------------------------------------
Alban Crequy (2):
      fuse: introduce new fs_type flag FS_IMA_NO_CACHE
      ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE

Mimi Zohar (2):
      ima: re-initialize iint->atomic_flags
      maintainers: update trusted keys

 MAINTAINERS                       |  1 +
 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/iint.c         |  1 +
 security/integrity/ima/ima_main.c | 15 +++++++++++++--
 5 files changed, 17 insertions(+), 3 deletions(-)

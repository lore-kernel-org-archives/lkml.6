Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbeDXL1C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:27:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753197AbeDXL07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:26:59 -0400
From: Cornelia Huck <cohuck@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/1] vfio-ccw: another bugfix
Date: Tue, 24 Apr 2018 13:26:55 +0200
Message-Id: <20180424112656.10243-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6cf09958f32b9667bb3ebadf74367c791112771b:

  s390: correct module section names for expoline code revert (2018-04-23 07:57:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180424

for you to fetch changes up to 427e522fc72395a4571b8dd7fe6d116927496bf7:

  vfio: ccw: fix cleanup if cp_prefetch fails (2018-04-23 14:11:20 +0200)

----------------------------------------------------------------
Another vfio-ccw bug fix: Don't clean up things on error that were
never translated in the first place.

----------------------------------------------------------------

Halil Pasic (1):
  vfio: ccw: fix cleanup if cp_prefetch fails

 drivers/s390/cio/vfio_ccw_cp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.14.3

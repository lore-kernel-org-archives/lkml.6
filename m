Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971748AbeCSVfj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:35:39 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:37679 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965173AbeCSVff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:35:35 -0400
X-Google-Smtp-Source: AG47ELuQbgbbVUUSak8L8iZTXr/Gt0Z3eGmfC/+vTw11eknZaiGDRA4CBmo4E+aFdYmFMnSUGi34Kg==
Date: Mon, 19 Mar 2018 14:35:32 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v4.16-rc6
Message-ID: <20180319213532.GK519464@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Two commits to fix the following subtle cgroup2 behavior bugs.

* cpu.max was rejecting config when it shouldn't.

* Thread mode enable was allowed when it shouldn't.

Thanks.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.16-fixes

for you to fetch changes up to d1897c9538edafd4ae6bbd03cc075962ddde2c21:

  cgroup: fix rule checking for threaded mode switching (2018-02-21 11:39:22 -0800)

----------------------------------------------------------------
Tejun Heo (2):
      sched, cgroup: Don't reject lower cpu.max on ancestors
      cgroup: fix rule checking for threaded mode switching

 kernel/cgroup/cgroup.c | 10 ++++++++++
 kernel/sched/core.c    | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
tejun

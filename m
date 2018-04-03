Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeDCOgb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:36:31 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38838 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeDCOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:36:30 -0400
X-Google-Smtp-Source: AIpwx49PHURop4iiEASS50fgFvr9JShb837P4WhypXJIAHk6wESJTNdUvXWyj2t5SkXpGhKZqVSv9Q==
Date: Tue, 3 Apr 2018 07:36:27 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue changes for v4.17-rc1
Message-ID: <20180403143627.GO388343@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

rcu_work addition and a couple trivial changes.

Thanks.

The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-4.17

for you to fetch changes up to f75da8a8a918d7c343a2ec95d1ed99e5689e0f23:

  workqueue: remove the comment about the old manager_arb mutex (2018-03-20 13:01:45 -0700)

----------------------------------------------------------------
Lai Jiangshan (2):
      workqueue: fix the comments of nr_idle
      workqueue: remove the comment about the old manager_arb mutex

Tejun Heo (3):
      RCU, workqueue: Implement rcu_work
      cgroup: Use rcu_work instead of explicit rcu and work item
      fs/aio: Use rcu_work instead of explicit rcu and work item

 fs/aio.c                    | 21 +++++-----------
 include/linux/cgroup-defs.h |  2 +-
 include/linux/workqueue.h   | 23 +++++++++++++++++
 kernel/cgroup/cgroup.c      | 21 ++++++----------
 kernel/workqueue.c          | 60 ++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 93 insertions(+), 34 deletions(-)

-- 
tejun

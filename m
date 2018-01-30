Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbeA3Sf5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:35:57 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46873 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeA3Sfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:35:55 -0500
X-Google-Smtp-Source: AH8x226k9GGwflJ4zAkXr30LNWjNAW7h++ssI5SoC7AWRgfsE3AAeQ1ROn6kqS7dL2dD/HXfCPhvMA==
Date: Tue, 30 Jan 2018 10:35:52 -0800
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v4.16-rc1
Message-ID: <20180130183552.GJ1121507@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Nothing too interesting.  Documentation updates and trivial changes;
however, this pull request does containt he previusly discussed
dropping of __must_check from strscpy().

Thanks.

The following changes since commit 4f58424da3deead2605e39a9df65f5f06107a3cb:

  cgroup: make cgroup.threads delegatable (2018-01-10 09:42:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.16

for you to fetch changes up to 03eac8b22194becd77d253fc546429ebb544aebf:

  Documentation: Fix 'file_mapped' -> 'mapped_file' (2018-01-30 09:52:11 -0800)

----------------------------------------------------------------
Florian Schmidt (1):
      Documentation: Fix 'file_mapped' -> 'mapped_file'

Maciej S. Szmigiero (1):
      cgroup, docs: document the root cgroup behavior of cpu and io controllers

Matt Roper (2):
      Documentation/cgroup-v1: fix outdated programming details
      cgroup: Update documentation reference

Roman Gushchin (1):
      cgroup, docs: document cgroup v2 device controller

Tejun Heo (2):
      Merge branch 'for-4.15-fixes' into for-4.16
      string: drop __must_check from strscpy() and restore strscpy() usages in cgroup

Vladimir Rutsky (1):
      cgroup-v2.txt: fix typos

 Documentation/cgroup-v1/cgroups.txt |  7 +---
 Documentation/cgroup-v1/memory.txt  |  4 +-
 Documentation/cgroup-v2.txt         | 77 ++++++++++++++++++++++++++++++++-----
 include/linux/cgroup-defs.h         |  2 +-
 include/linux/string.h              |  2 +-
 kernel/cgroup/cgroup.c              |  6 +--
 6 files changed, 76 insertions(+), 22 deletions(-)

-- 
tejun

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032413AbeCSVdQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:33:16 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:33172 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965184AbeCSVdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:33:09 -0400
X-Google-Smtp-Source: AG47ELtTmY7muCbkPojrfno0qj0frz2RNIw7GwdvHKFBpl14KZbTyPnxa4XIlTUVPrgs5bH2qSYHdQ==
Date: Mon, 19 Mar 2018 14:33:06 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue fixes for v4.16-rc6
Message-ID: <20180319213306.GJ519464@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Two low-impact workqueue commits.  One fixes workqueue creation error
path and the other removes the unused cancel_work().

The following changes since commit fc6eabbbf8ef99efed778dd5afabc83c21dba585:

  Merge tag 'nfs-for-4.16-4' of git://git.linux-nfs.org/projects/trondmy/linux-nfs (2018-03-12 10:47:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-4.16-fixes

for you to fetch changes up to 6417250d3f894e66a68ba1cd93676143f2376a6f:

  workqueue: remove unused cancel_work() (2018-03-13 13:37:42 -0700)

----------------------------------------------------------------
Arvind Yadav (1):
      workqueue: use put_device() instead of kfree()

Stephen Hemminger (1):
      workqueue: remove unused cancel_work()

 include/linux/workqueue.h |  1 -
 kernel/workqueue.c        | 10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

--
tejun

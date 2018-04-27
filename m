Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934344AbeD0OwJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:52:09 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41769 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934268AbeD0OwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:52:05 -0400
X-Google-Smtp-Source: AB8JxZpqvvYop3+/ci567ibBcAUQNOCBiGV4yL3hk8ILh+PW0GzOTuQrYY+cvTfvzmvfqq6641DQ/Q==
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 4.17-rc3
Date: Fri, 27 Apr 2018 16:51:32 +0200
Message-Id: <1524840692-30949-1-git-send-email-idryomov@gmail.com>
X-Mailer: git-send-email 2.4.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.17-rc3

for you to fetch changes up to 9c55ad1c214d9f8c4594ac2c3fa392c1c32431a7:

  libceph: validate con->state at the top of try_write() (2018-04-26 17:39:08 +0200)

----------------------------------------------------------------
A CephFS quota follow-up and fixes for two older issues in the
messenger layer, marked for stable.

----------------------------------------------------------------
Ilya Dryomov (3):
      libceph: un-backoff on tick when we have a authenticated session
      libceph: reschedule a tick in finish_hunting()
      libceph: validate con->state at the top of try_write()

Yan, Zheng (1):
      ceph: check if mds create snaprealm when setting quota

 fs/ceph/xattr.c       | 28 +++++++++++++++++++++++++---
 net/ceph/messenger.c  |  7 +++++++
 net/ceph/mon_client.c | 14 +++++++++++---
 3 files changed, 43 insertions(+), 6 deletions(-)

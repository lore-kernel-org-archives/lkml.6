Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeC3Nt1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 09:49:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35071 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3NtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 09:49:25 -0400
X-Google-Smtp-Source: AIpwx494VlsEZ/ySlBapsPrfAyilTzq+GZEELUWl1VZP9DbNRJk8axtAATJX5wLbllqJ67GmdGuM6Q==
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 4.16-rc8
Date: Fri, 30 Mar 2018 15:48:59 +0200
Message-Id: <1522417739-26858-1-git-send-email-idryomov@gmail.com>
X-Mailer: git-send-email 2.4.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.16-rc8

for you to fetch changes up to 85784f9395987a422fa04263e7c0fb13da11eb5c:

  ceph: only dirty ITER_IOVEC pages for direct read (2018-03-30 11:17:48 +0200)

----------------------------------------------------------------
A fix for a dio-enabled loop on ceph deadlock from Zheng, marked for
stable.

----------------------------------------------------------------
Yan, Zheng (1):
      ceph: only dirty ITER_IOVEC pages for direct read

 fs/ceph/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

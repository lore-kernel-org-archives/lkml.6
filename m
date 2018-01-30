Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeA3Rcx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:32:53 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:46287 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeA3Rcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:32:50 -0500
X-Google-Smtp-Source: AH8x224QehPmSanApdqjqjvtFTN4V82bD+LxMfgacXQQxVaiTomAoqUFJ3ycBUVJyn4MpwRmD02qrMmA6M8eVebebXA=
MIME-Version: 1.0
X-Originating-IP: [213.175.37.12]
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jan 2018 12:32:47 -0500
Message-ID: <CAHC9VhRN1bsCBh4mada12fYSvGrcKhi0LrVGmSO0J+rZ-kzkbw@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small pull request this time, just three patches, and one of these
is just a comment update (swap the FSF physical address for a URL).
The other two patches are small bug fixes found by szybot/syzkaller;
they individual patch descriptions should tell you all you ever wanted
to know.

All the patches pass the selinux-testsuite, and it looks to merge
cleanly on top of your tree (as of right now anyway).

Please pull, thanks.
-Paul
--
The following changes since commit 5794ed762ac2125299644494766704da94168ec0:

 selinux: remove extraneous initialization of slots_used and max_chain_len
          (2017-10-16 18:40:09 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
       tags/selinux-pr-20180130

for you to fetch changes up to 4b14752ec4e0d87126e636384cf37c8dd9df157c:

 selinux: skip bounded transition processing if the policy isn't loaded
          (2017-12-05 17:17:43 -0500)

----------------------------------------------------------------
selinux/stable-4.16 PR 20180130

----------------------------------------------------------------
Martin Kepplinger (1):
     security: replace FSF address with web source in license notices

Paul Moore (2):
     selinux: ensure the context is NUL terminated in security_context_to_sid_c
ore()
     selinux: skip bounded transition processing if the policy isn't loaded

security/selinux/include/netlabel.h |  3 +--
security/selinux/netlabel.c         |  3 +--
security/selinux/ss/services.c      | 21 +++++++++++----------
3 files changed, 13 insertions(+), 14 deletions(-)

-- 
paul moore
www.paul-moore.com

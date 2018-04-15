Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDOA2M (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 20:28:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33414 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDOA2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 20:28:11 -0400
X-Google-Smtp-Source: AIpwx48XJUVVAFXYf+Jb7IevqKNgrYRGmR5jPztFvIdr4RvcsH1/+NlDO90QBJdq5d0P6gDbMY5MuQ==
Date: Sun, 15 Apr 2018 09:28:07 +0900
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 4.17
Message-ID: <20180415002807.GN2836@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull,


The following changes since commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda:

  Linux 4.16 (2018-04-01 14:20:27 -0700)

are available in the git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to d56f3af9e801970d21c57621de3b42bc17eac152:

  openrisc: remove unused __ARCH_HAVE_MMU define (2018-04-08 02:15:47 +0900)

----------------------------------------------------------------
OpenRISC updates for v4.17

Just one small thing here, it came in a while back but I didnt have
anything in my 4.16 queue, still its the only thing for 4.17 so sending
it alone.

Small cleanup:
 - remove unused __ARCH_HAVE_MMU define

----------------------------------------------------------------
Tobias Klauser (1):
      openrisc: remove unused __ARCH_HAVE_MMU define

 arch/openrisc/include/uapi/asm/unistd.h | 2 --
 1 file changed, 2 deletions(-)

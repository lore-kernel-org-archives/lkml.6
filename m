Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754094AbeDJOSn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:18:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35248 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbeDJOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:18:39 -0400
X-Google-Smtp-Source: AIpwx495chg1HpL3iSAKK56SanpzgBm/SzJNobZUMAqMbuPKanHSV06K/+KkXE40PrsHssD5l+ygUw==
Message-ID: <1523369916.2998.2.camel@gmail.com>
Subject: [GIT PULL] c6x updates for 4.17
From: Mark Salter <msalter1887@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Date: Tue, 10 Apr 2018 10:18:36 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda:

  Linux 4.16 (2018-04-01 14:20:27 -0700)

are available in the Git repository at:

  git://linux-c6x.org/git/projects/linux-c6x-upstreaming.git tags/for-linus

for you to fetch changes up to 85fa2cc51104ee5b529ce85b12f4c8421888544f:

  c6x: pass endianness info to sparse (2018-04-10 09:58:58 -0400)

----------------------------------------------------------------
c6x changes 4.17

----------------------------------------------------------------
Jérémy Lefaure (1):
      c6x: remove unused KTHREAD_SIZE definition

Luc Van Oostenryck (1):
      c6x: pass endianness info to sparse

Randy Dunlap (1):
      c6x: fix platforms/plldata.c get_coreid build error

 arch/c6x/Makefile             | 1 +
 arch/c6x/kernel/asm-offsets.c | 1 -
 arch/c6x/platforms/plldata.c  | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

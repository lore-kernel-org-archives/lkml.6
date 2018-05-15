Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeEOCxx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:53:53 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:48210 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeEOCxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:53:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w4F2qVSs002191
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        user-mode-linux-user@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Andy Lutomirski <luto@amacapital.net>, Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 0/3] x86/build: clean-up of vdso Makefile
Date: Tue, 15 May 2018 11:52:21 +0900
Message-Id: <1526352744-28229-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Masahiro Yamada (3):
  x86/build: vdso: remove unused $(vobjs-nox32) in Makefile
  x86/build: vdso: remove unnecessary export in Makefile
  x86/build: vdso: put generated linker scripts to $(obj)/

 arch/x86/entry/vdso/Makefile | 11 ++++-------
 arch/x86/um/vdso/Makefile    |  4 ++--
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.7.4

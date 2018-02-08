Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBHXJ7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:09:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751788AbeBHXJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:09:58 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 0/2] objtool fixes on top of Peter's WARN UD2 patch
Date: Thu,  8 Feb 2018 17:09:24 -0600
Message-Id: <cover.1518130694.git.jpoimboe@redhat.com>
In-Reply-To: <20180208203146.GF577@pd.tnic>
References: <20180208203146.GF577@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf (2):
  objtool: Fix seg fault in ignore_unreachable_insn()
  x86: Annotate WARN-related UD2 as reachable

 arch/x86/include/asm/bug.h |  6 +++++-
 tools/objtool/check.c      | 12 +++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.14.3

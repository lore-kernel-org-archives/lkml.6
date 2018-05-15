Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeEOGXq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:23:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35689 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeEOGXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:23:44 -0400
Date: Mon, 14 May 2018 23:23:21 -0700
From: tip-bot for SeongJae Park <tipbot@zytor.com>
Message-ID: <tip-df9e0cc85c014868e57d2466239623f150c81b1a@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        will.deacon@arm.com, sj38.park@gmail.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        sj38.park@gmail.com
In-Reply-To: <1526338533-6044-4-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338533-6044-4-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/memory-barriers.txt/kokr: Update Korean
 translation to cross-reference "tools/memory-model/"
Git-Commit-ID: df9e0cc85c014868e57d2466239623f150c81b1a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  df9e0cc85c014868e57d2466239623f150c81b1a
Gitweb:     https://git.kernel.org/tip/df9e0cc85c014868e57d2466239623f150c81b1a
Author:     SeongJae Park <sj38.park@gmail.com>
AuthorDate: Mon, 14 May 2018 15:55:29 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:14 +0200

locking/memory-barriers.txt/kokr: Update Korean translation to cross-reference "tools/memory-model/"

Translate this commit to Korean:

  621df431b0ac ("Documentation/memory-barriers.txt: Cross-reference "tools/memory-model/"")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1526338533-6044-4-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 44e47c2d33cf..2c0ab128cd04 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -36,6 +36,9 @@ Documentation/memory-barriers.txt
 부분도 있고, 의도하진 않았지만 사람에 의해 쓰였다보니 불완전한 부분도 있습니다.
 이 문서는 리눅스에서 제공하는 다양한 메모리 배리어들을 사용하기 위한
 안내서입니다만, 뭔가 이상하다 싶으면 (그런게 많을 겁니다) 질문을 부탁드립니다.
+일부 이상한 점들은 공식적인 메모리 일관성 모델과 tools/memory-model/ 에 있는
+관련 문서를 참고해서 해결될 수 있을 겁니다.  그러나, 이 메모리 모델조차도 그
+관리자들의 의견의 집합으로 봐야지, 절대 옳은 예언자로 신봉해선 안될 겁니다.
 
 다시 말하지만, 이 문서는 리눅스가 하드웨어에 기대하는 사항에 대한 명세서가
 아닙니다.

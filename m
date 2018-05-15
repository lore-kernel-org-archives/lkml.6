Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeEOGYP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:24:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeEOGYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:24:14 -0400
Date: Mon, 14 May 2018 23:23:51 -0700
From: tip-bot for SeongJae Park <tipbot@zytor.com>
Message-ID: <tip-e2ba8041f2edb2e998f2bd7b3fd5f2bcf6a5edd4@git.kernel.org>
Cc: sj38.park@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org, akpm@linux-foundation.org,
        tglx@linutronix.de, will.deacon@arm.com, torvalds@linux-foundation.org,
        paulmck@linux.vnet.ibm.com
Reply-To: tglx@linutronix.de, akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        sj38.park@gmail.com, paulmck@linux.vnet.ibm.com,
        torvalds@linux-foundation.org, will.deacon@arm.com
In-Reply-To: <1526338533-6044-5-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338533-6044-5-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/memory-barriers.txt/kokr: Update Korean
 translation to fix description of data dependency barriers
Git-Commit-ID: e2ba8041f2edb2e998f2bd7b3fd5f2bcf6a5edd4
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

Commit-ID:  e2ba8041f2edb2e998f2bd7b3fd5f2bcf6a5edd4
Gitweb:     https://git.kernel.org/tip/e2ba8041f2edb2e998f2bd7b3fd5f2bcf6a5edd4
Author:     SeongJae Park <sj38.park@gmail.com>
AuthorDate: Mon, 14 May 2018 15:55:30 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:14 +0200

locking/memory-barriers.txt/kokr: Update Korean translation to fix description of data dependency barriers

Translate this commit to Korean:

  51de78892b12 ("memory-barriers: Fix description of data dependency barriers")

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
Link: http://lkml.kernel.org/r/1526338533-6044-5-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 2c0ab128cd04..99ef4ca1c1bf 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -427,8 +427,8 @@ CPU 에게 기대할 수 있는 최소한의 보장사항 몇가지가 있습니
      데이터 의존성 배리어는 읽기 배리어의 보다 완화된 형태입니다.  두개의 로드
      오퍼레이션이 있고 두번째 것이 첫번째 것의 결과에 의존하고 있을 때(예:
      두번째 로드가 참조할 주소를 첫번째 로드가 읽는 경우), 두번째 로드가 읽어올
-     데이터는 첫번째 로드에 의해 그 주소가 얻어지기 전에 업데이트 되어 있음을
-     보장하기 위해서 데이터 의존성 배리어가 필요할 수 있습니다.
+     데이터는 첫번째 로드에 의해 그 주소가 얻어진 뒤에 업데이트 됨을 보장하기
+     위해서 데이터 의존성 배리어가 필요할 수 있습니다.
 
      데이터 의존성 배리어는 상호 의존적인 로드 오퍼레이션들 사이의 부분적 순서
      세우기입니다; 스토어 오퍼레이션들이나 독립적인 로드들, 또는 중복되는

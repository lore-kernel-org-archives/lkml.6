Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CECECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FA82086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FA82086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbeGQJ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:59:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45827 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbeGQJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:59:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9RIpt1462189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:27:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9RHIs1462186;
        Tue, 17 Jul 2018 02:27:17 -0700
Date:   Tue, 17 Jul 2018 02:27:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for SeongJae Park <tipbot@zytor.com>
Message-ID: <tip-68ec3444b32158541f4bbd47ed9345634c56399d@git.kernel.org>
Cc:     sj38.park@gmail.com, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org, peterz@infradead.org,
        hpa@zytor.com, torvalds@linux-foundation.org,
        byungchul.park@lge.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, byungchul.park@lge.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          sj38.park@gmail.com, paulmck@linux.vnet.ibm.com
In-Reply-To: <20180716180605.16115-4-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-4-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/memory-barriers.txt/kokr: Update Korean
 translation to fix broken DMA vs. MMIO ordering example
Git-Commit-ID: 68ec3444b32158541f4bbd47ed9345634c56399d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  68ec3444b32158541f4bbd47ed9345634c56399d
Gitweb:     https://git.kernel.org/tip/68ec3444b32158541f4bbd47ed9345634c56399d
Author:     SeongJae Park <sj38.park@gmail.com>
AuthorDate: Mon, 16 Jul 2018 11:05:55 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:29:33 +0200

locking/memory-barriers.txt/kokr: Update Korean translation to fix broken DMA vs. MMIO ordering example

Translate this commit to Korean:

  5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")

[ paulmck: Updated based on feedback from Byungchul Park. ]
Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Byungchul Park <byungchul.park@lge.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180716180605.16115-4-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 .../translations/ko_KR/memory-barriers.txt         | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 921739d00f69..7f01fb1c1084 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1891,22 +1891,22 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
 		/* 소유권을 수정 */
 		desc->status = DEVICE_OWN;
 
-		/* MMIO 를 통해 디바이스에 공지를 하기 전에 메모리를 동기화 */
-		wmb();
-
 		/* 업데이트된 디스크립터의 디바이스에 공지 */
 		writel(DESC_NOTIFY, doorbell);
 	}
 
      dma_rmb() 는 디스크립터로부터 데이터를 읽어오기 전에 디바이스가 소유권을
-     내놓았음을 보장하게 하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
-     가졌음을 보기 전에 디스크립터에 데이터가 쓰였음을 보장합니다.  wmb() 는
-     캐시 일관성이 없는 (cache incoherent) MMIO 영역에 쓰기를 시도하기 전에
-     캐시 일관성이 있는 메모리 (cache coherent memory) 쓰기가 완료되었음을
-     보장해주기 위해 필요합니다.
-
-     consistent memory 에 대한 자세한 내용을 위해선 Documentation/DMA-API.txt
-     문서를 참고하세요.
+     내려놓았을 것을 보장하고, dma_wmb() 는 디바이스가 자신이 소유권을 다시
+     가졌음을 보기 전에 디스크립터에 데이터가 쓰였을 것을 보장합니다.  참고로,
+     writel() 을 사용하면 캐시 일관성이 있는 메모리 (cache coherent memory)
+     쓰기가 MMIO 영역에의 쓰기 전에 완료되었을 것을 보장하므로 writel() 앞에
+     wmb() 를 실행할 필요가 없음을 알아두시기 바랍니다.  writel() 보다 비용이
+     저렴한 writel_relaxed() 는 이런 보장을 제공하지 않으므로 여기선 사용되지
+     않아야 합니다.
+
+     writel_relaxed() 와 같은 완화된 I/O 접근자들에 대한 자세한 내용을 위해서는
+     "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
+     위해선 Documentation/DMA-API.txt 문서를 참고하세요.
 
 
 MMIO 쓰기 배리어

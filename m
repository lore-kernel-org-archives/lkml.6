Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521483946-2-11826539415944189637
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483945; b=FQopaCKMO+WGwiG3zzGifOPlVOlmtm/LCX75S5h+shmzR2e
    0OLq7BZVGMSDXIHgmU5+6SpkXfXFH2zVpxJRuP3RTpmciS4VFdVIj80mIJpkU4lI
    6aGh/rYnMKAgRCeufzdG5Qg2LJVqBHhqCatwgmqGWMHywXqlUE+KPNvCgF5/LME2
    9MB6oIq25nZnRTogTn8PjaPa+LznxbpV/WLOkFHRvD80ZqriwbnkGp10TRVloBd8
    2oNLulumUbRkfRaPv93h6sMVVOecqROLxZGwCqYuwczcPy6m2W+IAD+UkMM3R50C
    DX3Zq6AZjUlk5sGLb7+xf2ltANgjr7a0w3uJ79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483945; bh=TX3bDj2rGR4GJEKMv3tqJykIX6
    +mVrz5TV4sKNtOAB8=; b=vqmDz421A4kjym3rh2wQiQS8mniufGDi2iG+uPdK7W
    zn+fk5sicerSidd9pRykTYiPaMJKVGV4TVXQtZfrHcAHHYHb3+pH7n1kInFbQpT8
    XLm3DWezGU0iuhncRPGeHymSsBDgJoCeQqyvSXXbLiuEWgtsJOlJsDTWrQmZ+xfa
    Ig2suHG4aZ/XbB8uIUMJw3gY2gqFSEcBY0QHUyGpwTqsmclxUWIeArdoS+O9ZLc2
    2y3ajPXyi2BkWH9PV7QK82jBY/l69vbRZVXekb1Fsux4Mv56td/dcJJGpIQIRLdv
    POmlLHOsf07qlnZqXQVaRv0ldKyX40ENSwZ1XXWHLSow==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegheeiheenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegheeiheenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969761AbeCSSZk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:25:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969759AbeCSSZj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:25:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 171/241] sched: Stop resched_cpu() from sending IPIs to offline CPUs
Date: Mon, 19 Mar 2018 19:07:16 +0100
Message-Id: <20180319180758.237861935@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>


[ Upstream commit a0982dfa03efca6c239c52cabebcea4afb93ea6b ]

The rcutorture test suite occasionally provokes a splat due to invoking
resched_cpu() on an offline CPU:

WARNING: CPU: 2 PID: 8 at /home/paulmck/public_git/linux-rcu/arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x37/0x40
Modules linked in:
CPU: 2 PID: 8 Comm: rcu_preempt Not tainted 4.14.0-rc4+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
task: ffff902ede9daf00 task.stack: ffff96c50010c000
RIP: 0010:native_smp_send_reschedule+0x37/0x40
RSP: 0018:ffff96c50010fdb8 EFLAGS: 00010096
RAX: 000000000000002e RBX: ffff902edaab4680 RCX: 0000000000000003
RDX: 0000000080000003 RSI: 0000000000000000 RDI: 00000000ffffffff
RBP: ffff96c50010fdb8 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 00000000299f36ae R12: 0000000000000001
R13: ffffffff9de64240 R14: 0000000000000001 R15: ffffffff9de64240
FS:  0000000000000000(0000) GS:ffff902edfc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f7d4c642 CR3: 000000001e0e2000 CR4: 00000000000006e0
Call Trace:
 resched_curr+0x8f/0x1c0
 resched_cpu+0x2c/0x40
 rcu_implicit_dynticks_qs+0x152/0x220
 force_qs_rnp+0x147/0x1d0
 ? sync_rcu_exp_select_cpus+0x450/0x450
 rcu_gp_kthread+0x5a9/0x950
 kthread+0x142/0x180
 ? force_qs_rnp+0x1d0/0x1d0
 ? kthread_create_on_node+0x40/0x40
 ret_from_fork+0x27/0x40
Code: 14 01 0f 92 c0 84 c0 74 14 48 8b 05 14 4f f4 00 be fd 00 00 00 ff 90 a0 00 00 00 5d c3 89 fe 48 c7 c7 38 89 ca 9d e8 e5 56 08 00 <0f> ff 5d c3 0f 1f 44 00 00 8b 05 52 9e 37 02 85 c0 75 38 55 48
---[ end trace 26df9e5df4bba4ac ]---

This splat cannot be generated by expedited grace periods because they
always invoke resched_cpu() on the current CPU, which is good because
expedited grace periods require that resched_cpu() unconditionally
succeed.  However, other parts of RCU can tolerate resched_cpu() acting
as a no-op, at least as long as it doesn't happen too often.

This commit therefore makes resched_cpu() invoke resched_curr() only if
the CPU is either online or is the current CPU.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -508,7 +508,8 @@ void resched_cpu(int cpu)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&rq->lock, flags);
-	resched_curr(rq);
+	if (cpu_online(cpu) || cpu == smp_processor_id())
+		resched_curr(rq);
 	raw_spin_unlock_irqrestore(&rq->lock, flags);
 }
 

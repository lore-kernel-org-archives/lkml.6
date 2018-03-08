Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeCHVm1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:42:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:63461 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbeCHVm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:42:26 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,442,1515484800";
   d="scan'208";a="40386832"
Date: Fri, 9 Mar 2018 05:41:27 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [rcu:rcu/dev 39/39] kernel/rcu/tree_exp.h:163:9: sparse: incorrect
 type in argument 1 (different modifiers)
Message-ID: <201803090524.gbCGY9DF%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/dev
head:   b8909ec707bb5beba94e7c7d62cc6b3115ceae50
commit: b8909ec707bb5beba94e7c7d62cc6b3115ceae50 [39/39] rcu: Protect all sync_rcu_preempt_exp_done() with rcu_node lock
reproduce:
        # apt-get install sparse
        git checkout b8909ec707bb5beba94e7c7d62cc6b3115ceae50
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/init.h:134:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:135:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:268:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:269:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/printk.h:200:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:32:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:34:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:37:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:38:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:40:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:42:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:43:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:45:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:46:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:49:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/qspinlock.h:53:32: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:34:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:35:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:62:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:64:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:173:8: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:174:8: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:174:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:176:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:178:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:180:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/apic.h:254:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/apic.h:430:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/io_apic.h:184:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:113:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:125:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:126:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:110:33: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:112:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:114:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:118:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:126:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/workqueue.h:646:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/workqueue.h:647:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/memory_hotplug.h:221:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mmzone.h:1292:15: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/io.h:47:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/kmemleak.h:29:33: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/kasan.h:29:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/kasan.h:30:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pgtable.h:28:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/slab.h:135:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/slab.h:716:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/hrtimer.h:497:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/wait_bit.h:41:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:63:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:64:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:65:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:66:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:2421:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:2422:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:3329:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/cred.h:167:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/nsproxy.h:74:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:1753:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:1941:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:2083:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:2671:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/vdso.h:44:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/ftrace.h:462:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/suspend.h:254:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/suspend.h:375:20: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/suspend.h:379:20: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.h:442:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.h:452:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.h:477:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.h:479:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.c:3616:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.c:3931:12: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.c:3993:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.c:4077:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.c:4155:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.c:4176:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/clocksource.h:195:29: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/tick.h:16:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/sched/isolation.h:23:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:71:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:833:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:922:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:1315:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:1648:12: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:1784:12: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:1792:12: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:2317:6: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:2363:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:2439:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree_plugin.h:2454:13: sparse: attribute 'indirect_branch': unknown attribute
   kernel/rcu/tree.c:345:6: sparse: symbol 'rcu_dynticks_curr_cpu_in_eqs' was not declared. Should it be static?
   kernel/rcu/tree.c:3953:21: sparse: incorrect type in argument 1 (different modifiers) @@    expected int ( *threadfn )( ... ) @@    got int ( [noreint ( *threadfn )( ... ) @@
   kernel/rcu/tree.c:3953:21:    expected int ( *threadfn )( ... )
   kernel/rcu/tree.c:3953:21:    got int ( [noreturn] *<noident> )( ... )
>> kernel/rcu/tree_exp.h:163:9: sparse: incorrect type in argument 1 (different modifiers) @@    expected struct lockdep_map const *lock @@    got strustruct lockdep_map const *lock @@
   kernel/rcu/tree_exp.h:163:9:    expected struct lockdep_map const *lock
   kernel/rcu/tree_exp.h:163:9:    got struct lockdep_map [noderef] *<noident>
   kernel/rcu/tree.c:1752:9: sparse: context imbalance in 'rcu_start_future_gp' - different lock contexts for basic block
   kernel/rcu/tree.c:2786:9: sparse: context imbalance in 'force_qs_rnp' - different lock contexts for basic block
   kernel/rcu/tree.c:2849:25: sparse: context imbalance in 'force_quiescent_state' - unexpected unlock
   kernel/rcu/tree_exp.h:203:9: sparse: too many warnings

vim +163 kernel/rcu/tree_exp.h

   151	
   152	/*
   153	 * Return non-zero if there is no RCU expedited grace period in progress
   154	 * for the specified rcu_node structure, in other words, if all CPUs and
   155	 * tasks covered by the specified rcu_node structure have done their bit
   156	 * for the current expedited grace period.  Works only for preemptible
   157	 * RCU -- other RCU implementation use other means.
   158	 *
   159	 * Caller must hold the specificed rcu_node structure's ->lock
   160	 */
   161	static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
   162	{
 > 163		lockdep_assert_held(&rnp->lock);
   164	
   165		return rnp->exp_tasks == NULL &&
   166		       READ_ONCE(rnp->expmask) == 0;
   167	}
   168	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

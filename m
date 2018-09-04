Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66852C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2A22082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2A22082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeIDTig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:38:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:14104 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeIDTig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:38:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 08:13:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="68295182"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2018 08:13:04 -0700
Date:   Tue, 4 Sep 2018 23:25:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org
Subject: [tip:x86/paravirt 2/15] arch/x86/xen/mmu_pv.c:105:1: sparse: symbol
 'xen_reservation_lock' was not declared. Should it be static?
Message-ID: <20180904152539.GW17047@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/paravirt
head:   495310e4f2dd857c4d5a62806a04cb8ba53855c1
commit: f030aade9165080f3539fb86fc2ce9ffc391813c [2/15] x86/xen: Move pv specific parts of arch/x86/xen/mmu.c to mmu_pv.c
reproduce:
        # apt-get install sparse
        git checkout f030aade9165080f3539fb86fc2ce9ffc391813c
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> arch/x86/xen/mmu_pv.c:105:1: sparse: symbol 'xen_reservation_lock' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:373:20: sparse: symbol 'xen_pte_val' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:381:20: sparse: symbol 'xen_pgd_val' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:387:17: sparse: symbol 'xen_make_pte' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:395:17: sparse: symbol 'xen_make_pgd' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:402:20: sparse: symbol 'xen_pmd_val' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:460:17: sparse: symbol 'xen_make_pmd' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:468:20: sparse: symbol 'xen_pud_val' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:474:17: sparse: symbol 'xen_make_pud' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:558:20: sparse: symbol 'xen_p4d_val' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:564:17: sparse: symbol 'xen_make_p4d' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:1547:17: sparse: symbol 'xen_make_pte_init' was not declared. Should it be static?
   arch/x86/xen/mmu_pv.c:2101:45: sparse: expression using sizeof(void)
   arch/x86/xen/mmu_pv.c:2105:51: sparse: expression using sizeof(void)
   arch/x86/xen/mmu_pv.c:2110:59: sparse: expression using sizeof(void)
   arch/x86/xen/mmu_pv.c:2748:29: sparse: expression using sizeof(void)
   arch/x86/xen/mmu_pv.c:694:19: sparse: context imbalance in 'xen_pte_lock' - wrong count at exit
   arch/x86/xen/mmu_pv.c:706:13: sparse: context imbalance in 'xen_pte_unlock' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

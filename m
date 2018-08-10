Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC74FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDD621A74
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDD621A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeHJD56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 23:57:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:38265 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbeHJD56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 23:57:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 18:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,217,1531810800"; 
   d="scan'208";a="62034477"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2018 18:30:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fnwFn-000ENu-By; Fri, 10 Aug 2018 09:30:11 +0800
Date:   Fri, 10 Aug 2018 09:29:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Manish Chopra <manish.chopra@cavium.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com, linux-kernel@vger.kernel.org
Subject: [net-next:master 1939/1953]
 drivers/net/ethernet/qlogic/qede/qede_main.c:539:5: sparse: symbol
 'qede_setup_tc' was not declared. Should it be static?
Message-ID: <201808100919.Z4vmd4cO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master
head:   36d2f761b5aa688567b6aebdc6d68e73682275d4
commit: 5e7baf0fcb2a3aef7329f3c7543d4695a46bd321 [1939/1953] qed/qede: Multi CoS support.
reproduce:
        # apt-get install sparse
        git checkout 5e7baf0fcb2a3aef7329f3c7543d4695a46bd321
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/qlogic/qede/qede_main.c:539:5: sparse: symbol 'qede_setup_tc' was not declared. Should it be static?
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/slab.h:631:13: sparse: not a function <noident>
   drivers/net/ethernet/qlogic/qede/qede_main.c:1175:19: sparse: expression using sizeof(void)
   drivers/net/ethernet/qlogic/qede/qede_main.c:1175:19: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

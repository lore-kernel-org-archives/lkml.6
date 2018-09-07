Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE0CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9522083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9522083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeIGGUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:20:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:43207 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeIGGUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:20:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 18:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="88361143"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2018 18:41:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fy5ll-000D9l-2V; Fri, 07 Sep 2018 09:41:09 +0800
Date:   Fri, 7 Sep 2018 09:41:07 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Weilin Chang <weilin.chang@cavium.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Felix Manlunas <felix.manlunas@cavium.com>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: [net-next:master 73/74]
 drivers/net/ethernet/cavium/liquidio/lio_core.c:1360:5: sparse: symbol
 'lio_fetch_vf_stats' was not declared. Should it be static?
Message-ID: <201809070936.Xhh3hpBt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master
head:   ddc4d236dc71b255ff4cb8394f5fce2739a1d138
commit: 488752220b4a73ae131ca3e7c0c83b9f1bf092e4 [73/74] liquidio: Add spoof checking on a VF MAC address
reproduce:
        # apt-get install sparse
        git checkout 488752220b4a73ae131ca3e7c0c83b9f1bf092e4
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/slab.h:631:13: sparse: not a function <noident>
   include/linux/slab.h:631:13: sparse: not a function <noident>
   include/linux/slab.h:631:13: sparse: not a function <noident>
   include/linux/slab.h:631:13: sparse: not a function <noident>
   include/linux/slab.h:631:13: sparse: not a function <noident>
   include/linux/slab.h:631:13: sparse: not a function <noident>
>> drivers/net/ethernet/cavium/liquidio/lio_core.c:1360:5: sparse: symbol 'lio_fetch_vf_stats' was not declared. Should it be static?
   include/linux/slab.h:631:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

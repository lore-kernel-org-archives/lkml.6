Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 77mYMYPjGluIQAAAmS7hNA
	; Fri, 08 Jun 2018 20:14:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BDD47607A4; Fri,  8 Jun 2018 20:14:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A9AF2605A5;
	Fri,  8 Jun 2018 20:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9AF2605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeFHUOE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:14:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:5818 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753077AbeFHUM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 13:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,491,1520924400";
   d="scan'208";a="57698382"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2018 13:12:27 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fRNkF-0008Bm-Pn; Sat, 09 Jun 2018 04:12:23 +0800
Date: Sat, 9 Jun 2018 04:11:26 +0800
From: kbuild test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [rcu:rcu/dev 114/116] drivers/iommu/amd_iommu.c:3566:21: sparse:
 symbol 'stupid_workaround' was not declared. Should it be static?
Message-ID: <201806090402.ONNRpjQE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/dev
head:   f20dfe840ba05efdc4071106cffa31cb67cf6bc8
commit: 814ee31d1f906ad00daccb58944ab16fa279690c [114/116] fixup! EXP iommu: Placeholder for fix in mainline
reproduce:
        # apt-get install sparse
        git checkout 814ee31d1f906ad00daccb58944ab16fa279690c
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/iommu/amd_iommu.c:3539:30: sparse: expression using sizeof(void)
   drivers/iommu/amd_iommu.c:3542:36: sparse: expression using sizeof(void)
   drivers/iommu/amd_iommu.c:3542:36: sparse: expression using sizeof(void)
>> drivers/iommu/amd_iommu.c:3566:21: sparse: symbol 'stupid_workaround' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

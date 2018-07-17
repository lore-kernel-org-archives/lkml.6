Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4B520877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4B520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGQBgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:36:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:42707 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbeGQBgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:36:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 18:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="67534816"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2018 18:06:45 -0700
Date:   Tue, 17 Jul 2018 09:17:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [net-next:master 598/621]
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c:621:5: sparse: symbol
 'mvpp2_flow_get_hek_fields' was not declared. Should it be static?
Message-ID: <20180717011750.GY10593@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master
head:   9cee8c4375431d5087466eacf6f8f436210e56ea
commit: d33ec452500798868c430c5e2e4b5e8399ae70e3 [598/621] net: mvpp2: add an RSS classification step for each flow
reproduce:
        # apt-get install sparse
        git checkout d33ec452500798868c430c5e2e4b5e8399ae70e3
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__
:::::: branch date: 4 hours ago
:::::: commit date: 31 hours ago

   drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c:560:23: sparse: symbol 'mvpp2_cls_flow_get' was not declared. Should it be static?
>> drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c:621:5: sparse: symbol 'mvpp2_flow_get_hek_fields' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

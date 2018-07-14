Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC42ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7576208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7576208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbeGNBpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 21:45:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:11181 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbeGNBpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 21:45:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 18:28:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,350,1526367600"; 
   d="scan'208";a="72629974"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2018 18:28:23 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fe9ME-000POx-Sx; Sat, 14 Jul 2018 09:28:22 +0800
Date:   Sat, 14 Jul 2018 09:27:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [net-next:master 597/618]
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c:444:23: sparse: symbol
 'mvpp2_cls_flow_get' was not declared. Should it be static?
Message-ID: <201807140954.503e2wSM%fengguang.wu@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master
head:   c921c2077b32081617789a645120148bc8b60c98
commit: f9358e12a0af53d107df09d4c0254425b6a10468 [597/618] net: mvpp2: split ingress traffic into multiple flows
reproduce:
        # apt-get install sparse
        git checkout f9358e12a0af53d107df09d4c0254425b6a10468
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c:444:23: sparse: symbol 'mvpp2_cls_flow_get' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

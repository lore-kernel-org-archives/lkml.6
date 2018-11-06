Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C992DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C772086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C772086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeKFU7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:59:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:58283 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbeKFU7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:59:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 03:34:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="103825480"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Nov 2018 03:34:15 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gJzcd-000DJI-5P; Tue, 06 Nov 2018 19:34:15 +0800
Date:   Tue, 6 Nov 2018 19:33:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/staging/media/sunxi/cedrus/cedrus.c:421:3-8: No need to set
 .owner here. The core will do it.
Message-ID: <201811061917.7LMfScZW%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   163c8d54a997153ee1a1e07fcac087492ad85b37
commit: 50e761516f2b8c0cdeb31a8c6ca1b4ef98cd13f1 media: platform: Add Cedrus VPU decoder driver
date:   6 weeks ago


coccinelle warnings: (new ones prefixed by >>)

>> drivers/staging/media/sunxi/cedrus/cedrus.c:421:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

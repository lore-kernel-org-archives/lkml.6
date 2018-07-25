Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CDCC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A683620843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A683620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbeGYTJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:09:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:12902 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728913AbeGYTJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:09:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 10:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,401,1526367600"; 
   d="scan'208";a="59434509"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2018 10:57:08 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fiO27-000M5G-Ou; Thu, 26 Jul 2018 01:57:07 +0800
Date:   Thu, 26 Jul 2018 01:56:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: drivers/video/fbdev/omap2/omapfb/omapfb-main.c:290:9-10: WARNING:
 return of 0/1 in function 'cmp_var_to_colormode' with return type bool
Message-ID: <201807260144.q4WK2PMA%fengguang.wu@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9981b4fb8684883dcc0daf088891ff32260b9794
commit: 7378f1149884b183631c6c16c0f1c62bcd7d759d media: omap2: omapfb: allow building it with COMPILE_TEST
date:   3 months ago


coccinelle warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/omap2/omapfb/omapfb-main.c:290:9-10: WARNING: return of 0/1 in function 'cmp_var_to_colormode' with return type bool
--
>> drivers/video/fbdev/omap2/omapfb/dss/dss_features.c:895:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
   Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
--
>> drivers/video/fbdev/omap2/omapfb/dss/core.c:141:2-26: WARNING: NULL check before some freeing functions is not needed.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

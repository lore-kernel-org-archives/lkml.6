Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7BBC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B85720870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B85720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeG2XdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:33:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:1388 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731589AbeG2XdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:33:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2018 15:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,420,1526367600"; 
   d="scan'208";a="249390968"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2018 15:01:12 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fjtkW-000TEu-7T; Mon, 30 Jul 2018 06:01:12 +0800
Date:   Mon, 30 Jul 2018 06:00:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     kbuild-all@01.org, manivannan.sadhasivam@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Re: [PATCH v3 4/5] pinctrl: actions: Add Actions Semi S700 pinctrl
 driver
Message-ID: <201807300552.cJ0VSU1K%fengguang.wu@intel.com>
References: <20180729200038.11795-5-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729200038.11795-5-sravanhome@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravanan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pinctrl/devel]
[also build test WARNING on next-20180727]
[cannot apply to v4.18-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Saravanan-Sekar/Add-Actions-Semi-S700-pinctrl-support/20180730-040252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pinctrl/actions/pinctrl-s700.c:228:31: sparse: symbol 's700_pads' was not declared. Should it be static?
>> drivers/pinctrl/actions/pinctrl-s700.c:1552:30: sparse: symbol 's700_functions' was not declared. Should it be static?
>> drivers/pinctrl/actions/pinctrl-s700.c:1700:20: sparse: symbol 's700_padinfo' was not declared. Should it be static?
   drivers/pinctrl/actions/pinctrl-s700.c:1589:10: sparse: Initializer entry defined twice
   drivers/pinctrl/actions/pinctrl-s700.c:1594:10:   also defined here

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

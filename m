Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0E2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8A020854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8A020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeKKBnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:43:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:54805 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeKKBnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:43:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2018 07:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,488,1534834800"; 
   d="scan'208";a="88276684"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Nov 2018 07:58:09 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gLVeD-0007N7-Cb; Sat, 10 Nov 2018 23:58:09 +0800
Date:   Sat, 10 Nov 2018 23:57:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     zoro <long17.cool@163.com>
Cc:     kbuild-all@01.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zoro <long17.cool@163.com>
Subject: Re: [PATCH 2/3] rtc: sd3078: new driver.
Message-ID: <201811102357.OsWIpHwn%fengguang.wu@intel.com>
References: <1541839433-28811-2-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541839433-28811-2-git-send-email-long17.cool@163.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zoro,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on v4.20-rc1 next-20181109]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zoro/dt-bindings-define-vendor-prefix-for-whwave-Inc/20181110-205048
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/rtc/rtc-sd3078.c:248:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

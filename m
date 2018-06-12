Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 75D4BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C72208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C72208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934152AbeFLOun (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:50:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:9886 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932750AbeFLOul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:50:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 07:50:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="231959332"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2018 07:50:38 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fSkd4-000WXW-6I; Tue, 12 Jun 2018 22:50:38 +0800
Date:   Tue, 12 Jun 2018 22:50:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     kbuild-all@01.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
Message-ID: <201806122228.8vAQXcD6%fengguang.wu@intel.com>
References: <20180612113907.15043-2-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612113907.15043-2-niklas.cassel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ath6kl/ath-next]
[also build test WARNING on next-20180612]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Niklas-Cassel/ath10k-do-not-mix-spaces-and-tabs-in-Kconfig/20180612-194241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/wireless/ath/ath10k/snoc.c:823:5: sparse: symbol 'ath10k_snoc_get_ce_id_from_irq' was not declared. Should it be static?
>> drivers/net/wireless/ath/ath10k/snoc.c:871:6: sparse: symbol 'ath10k_snoc_init_napi' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

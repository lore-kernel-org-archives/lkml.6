Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 850F3C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E6D208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E6D208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755129AbeFNKiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:38:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:6251 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754794AbeFNKim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:38:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 03:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="57289842"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2018 03:38:40 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fTPeJ-0005mY-E8; Thu, 14 Jun 2018 18:38:39 +0800
Date:   Thu, 14 Jun 2018 18:38:10 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     kbuild-all@01.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, robh@kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rohit Kumar <rohitkr@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 2/2] clk: qcom: Add lpass clock controller driver for
 SDM845
Message-ID: <201806141715.reXn15om%fengguang.wu@intel.com>
References: <1528961943-12506-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528961943-12506-3-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on next-20180614]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Taniya-Das/Add-support-for-LPASS-clock-controller-for-SDM845/20180614-155144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/clk/qcom/lpasscc-sdm845.c:32:19: sparse: symbol 'gcc_lpass_sway_clk' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

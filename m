Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D631C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B652219F2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B652219F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeHLAGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 20:06:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:50706 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbeHLAGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 20:06:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2018 14:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,226,1531810800"; 
   d="scan'208";a="254001822"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2018 14:30:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fobSe-000BCd-69; Sun, 12 Aug 2018 05:30:12 +0800
Date:   Sun, 12 Aug 2018 05:30:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     kbuild-all@01.org, ctatlor97@gmail.com,
        linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Add Global Clock controller (GCC) driver for
 SDM660
Message-ID: <201808120507.D1Aw6GcB%fengguang.wu@intel.com>
References: <20180810202123.29238-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810202123.29238-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Craig,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on agross/for-next]
[also build test WARNING on v4.18-rc8]
[cannot apply to next-20180810]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Craig-Tatlor/clk-qcom-Add-Global-Clock-controller-GCC-driver-for-SDM660/20180811-150111
base:   https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/clk/qcom/gcc-sdm660.c:2255:15: sparse: symbol 'gcc_sdm660_hws' was not declared. Should it be static?
   drivers/clk/qcom/gcc-sdm660.c:2304:10: sparse: Initializer entry defined twice
   drivers/clk/qcom/gcc-sdm660.c:2306:10:   also defined here

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

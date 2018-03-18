Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbeCRV23 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 17:28:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:36729 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754304AbeCRV20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 17:28:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,327,1517904000";
   d="scan'208";a="209314996"
Date: Mon, 19 Mar 2018 05:28:08 +0800
From: kbuild test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbuild-all@01.org, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5 12/12] clk: actions: Add S900 SoC clock support
Message-ID: <201803190542.EmeV4ajI%fengguang.wu@intel.com>
References: <20180317100952.28538-13-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180317100952.28538-13-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[cannot apply to next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Manivannan-Sadhasivam/Add-clock-driver-for-Actions-S900-SoC/20180319-015124
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/clk/actions/owl-s900.c:33:46: sparse: constant 2700000000 is so big it is long
   drivers/clk/actions/owl-s900.c:604:18: sparse: Initializer entry defined twice
   drivers/clk/actions/owl-s900.c:639:18:   also defined here

vim +33 drivers/clk/actions/owl-s900.c

    31	
    32	static struct clk_pll_table clk_edp_pll_table[] = {
  > 33		{0, 810000000}, {1, 1350000000}, {2, 2700000000},
    34		{0, 0},
    35	};
    36	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

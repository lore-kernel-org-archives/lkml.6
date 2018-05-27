Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935226AbeE0I3H (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 04:29:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:4489 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934160AbeE0I3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 04:29:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,446,1520924400";
   d="scan'208";a="227631914"
Date: Sun, 27 May 2018 16:28:22 +0800
From: kbuild test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: kbuild-all@01.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH 7/9] clk: bd71837: Build ROHM BD71837 PMIC clock driver
Message-ID: <201805271456.NRwg0RUS%fengguang.wu@intel.com>
References: <20180524055955.GH4249@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524055955.GH4249@localhost.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ljones-mfd/for-mfd-next]
[also build test WARNING on v4.17-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/mfd-regulator-clk-bd71837-ROHM-BD71837-PMIC-driver/20180526-192351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/clk/clk-bd71837.c:145:6-11: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeDMGES (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 02:04:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:17735 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752157AbeDMGER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 02:04:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,444,1517904000";
   d="scan'208";a="36951058"
Date: Fri, 13 Apr 2018 14:03:59 +0800
From: kbuild test robot <lkp@intel.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: kbuild-all@01.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 3/5] net: stmmac: dwmac-sun8i: Allow getting syscon
 regmap from device
Message-ID: <201804131338.J3POccon%fengguang.wu@intel.com>
References: <20180411141641.14675-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411141641.14675-4-icenowy@aosc.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.16 next-20180412]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Icenowy-Zheng/Add-support-in-dwmac-sun8i-for-accessing-EMAC-clock/20180413-004816
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c:82:24: sparse: symbol 'old_syscon_reg_field' was not declared. Should it be static?
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c:89:24: sparse: symbol 'single_reg_field' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

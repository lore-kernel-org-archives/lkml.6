Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeCPMYC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:24:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:35825 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeCPMYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:24:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="25799399"
Date: Fri, 16 Mar 2018 20:22:33 +0800
From: kbuild test robot <lkp@intel.com>
To: gabriel.fernandez@st.com
Cc: kbuild-all@01.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, gabriel.fernandez@st.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gabriel.fernandez.st@gmail.com,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org
Subject: Re: [PATCH v2 2/2] reset: stm32mp1: Enable stm32mp1 reset driver
Message-ID: <201803162025.oENTlaMr%fengguang.wu@intel.com>
References: <1521045001-30788-3-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521045001-30788-3-git-send-email-gabriel.fernandez@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20180309]
[also build test WARNING on v4.16-rc5]
[cannot apply to linus/master v4.16-rc4 v4.16-rc3 v4.16-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/gabriel-fernandez-st-com/Introduce-STM32MP1-Reset-driver/20180316-082607
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/reset/reset-stm32mp1.c:73:32: sparse: symbol 'stm32_reset_ops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

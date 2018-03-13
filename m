Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeCMMwl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:52:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:47773 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751430AbeCMMwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:52:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="scan'208";a="37774463"
Date: Tue, 13 Mar 2018 20:52:26 +0800
From: kbuild test robot <lkp@intel.com>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: kbuild-all@01.org, Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [RESEND PATCH v1 3/6] i2c: i2c-stm32f7: Add initial SMBus
 protocols support
Message-ID: <201803132034.7iIeYSyJ%fengguang.wu@intel.com>
References: <1520852023-27083-4-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520852023-27083-4-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Yves,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180313]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pierre-Yves-MORDRET/Add-different-features-for-I2C/20180313-193102


coccinelle warnings: (new ones prefixed by >>)

>> drivers/i2c/busses/i2c-stm32f7.c:995:2-3: Unneeded semicolon
   drivers/i2c/busses/i2c-stm32f7.c:944:2-3: Unneeded semicolon
   drivers/i2c/busses/i2c-stm32f7.c:875:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

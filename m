Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeD1FRe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 01:17:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:22525 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbeD1FRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 01:17:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,337,1520924400";
   d="scan'208";a="35894663"
Date: Sat, 28 Apr 2018 13:16:43 +0800
From: kbuild test robot <lkp@intel.com>
To: Sujeev Dias <sdias@codeaurora.org>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Sujeev Dias <sdias@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tony Truong <truong@codeaurora.org>
Subject: Re: [PATCH v1 4/4] mhi_bus: dev: uci: add user space interface driver
Message-ID: <201804281203.KNAh1ol2%fengguang.wu@intel.com>
References: <1524795811-21399-5-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524795811-21399-5-git-send-email-sdias@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sujeev,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc2 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sujeev-Dias/mhi_bus-core-Add-support-for-MHI-host-interface/20180428-065959


coccinelle warnings: (new ones prefixed by >>)

>> drivers/bus/mhi/devices/mhi_uci.c:556:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeEDUQU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:16:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:4821 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbeEDUQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:16:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="221714036"
Date: Sat, 5 May 2018 04:16:06 +0800
From: kbuild test robot <lkp@intel.com>
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: kbuild-all@01.org, djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ACPI: APD: Add AMD misc clock handler support
Message-ID: <201805050356.n04IuGDl%fengguang.wu@intel.com>
References: <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akshu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.17-rc3 next-20180504]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Akshu-Agrawal/clk-x86-Add-ST-oscout-platform-clock/20180504-220653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/acpi/acpi_apd.c:114:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeDFHdt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:33:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:48150 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeDFHdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:33:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,414,1517904000";
   d="scan'208";a="43927702"
Date: Fri, 6 Apr 2018 15:33:28 +0800
From: kbuild test robot <lkp@intel.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 4/8] Input: elantech - split device info into a separate
 structure
Message-ID: <201804061445.qVN8iyNr%fengguang.wu@intel.com>
References: <20180405132537.3218-5-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405132537.3218-5-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20180405]
[cannot apply to input/next v4.16 v4.16-rc7 v4.16-rc6 v4.16]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Tissoires/Input-support-for-latest-Lenovo-thinkpads-series-80/20180406-110729
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/input/mouse/elantech.c:1665:5: sparse: symbol 'elantech_query_info' was not declared. Should it be static?
   drivers/input/mouse/elantech.c: In function 'elantech_init':
   drivers/input/mouse/elantech.c:1839:9: warning: 'error' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return error;
            ^~~~~

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeDAAda (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 20:33:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:2443 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeDAAd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 20:33:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,389,1517904000";
   d="scan'208";a="212939946"
Date: Sun, 1 Apr 2018 08:32:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: Re: [PATCH net-next v3 1/3] vmcore: add API to collect hardware dump
 in second kernel
Message-ID: <201804010849.ZM0J7PZb%fengguang.wu@intel.com>
References: <194d1e289b385f2cbd4cb2c2569af93723a9cfb8.1522483891.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194d1e289b385f2cbd4cb2c2569af93723a9cfb8.1522483891.git.rahul.lakkireddy@chelsio.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Rahul-Lakkireddy/kernel-add-support-to-collect-hardware-logs-in-crash-recovery-kernel/20180401-060904
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> fs/proc/vmcore.c:1199:5: sparse: symbol '__vmcore_add_device_dump' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

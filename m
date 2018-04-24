Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeDXKK6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:10:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:29025 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932342AbeDXKK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:10:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,322,1520924400";
   d="scan'208";a="35992817"
Date: Tue, 24 Apr 2018 18:10:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Ahmed Abdelsalam <amsalam20@gmail.com>
Cc: kbuild-all@01.org, davem@davemloft.net, dav.lebrun@gmail.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ahmed Abdelsalam <amsalam20@gmail.com>
Subject: Re: [net-next 2/2] ipv6: sr: Compute flowlabel of outer IPv6 header
 for seg6 encap mode
Message-ID: <201804241636.206YllIi%fengguang.wu@intel.com>
References: <1524519420-1612-2-git-send-email-amsalam20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524519420-1612-2-git-send-email-amsalam20@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmed,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Ahmed-Abdelsalam/ipv6-sr-add-a-per-namespace-sysctl-to-control-seg6-flowlabel/20180424-142142
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> net/ipv6/seg6_iptunnel.c:95:8: sparse: symbol 'seg6_make_flowlabel' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

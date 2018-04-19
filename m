Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeDSF6L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:58:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:6541 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752325AbeDSF6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:58:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="43027687"
Date: Thu, 19 Apr 2018 13:58:03 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: linux-mm@kvack.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, lkp@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Huang Ying <ying.huang@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
        LKP <lkp@intel.com>, Philip Li <philip.li@intel.com>
Subject: Re: WARNING: stack going in the wrong direction?
 ip=__schedule+0x489/0x830
Message-ID: <20180419055803.ty5nxeb36qwoywi7@wfg-t540p.sh.intel.com>
References: <20180419054941.hpmfbyybqhlscghh@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180419054941.hpmfbyybqhlscghh@wfg-t540p.sh.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 01:49:41PM +0800, Fengguang Wu wrote:
>Hello,
>
>FYI this warning dates back to v4.16-rc5 .

>It's rather rare and often happen together with other errors.

Sorry, that should be 0day didn't catch this particular WARNING.
So it just occasionally show up in the context of other errors.

I jut added that WARNING pattern to 0day and hope we can get more
information about it.

Thanks,
Fengguang

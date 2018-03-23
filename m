Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeCWTsY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:48:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:63804 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbeCWTsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:48:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="185458817"
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from
 PROT_EXEC
To: Thomas Gleixner <tglx@linutronix.de>
References: <20180323180903.33B17168@viggo.jf.intel.com>
 <20180323180911.E43ACAB8@viggo.jf.intel.com>
 <CALvZod6F8x-smAE7sEGfJ3Ds5p6M5Qj6gd-P-VLejuBxfU6niQ@mail.gmail.com>
 <f7897068-18a3-d88b-0458-5dcf05d7ffc2@intel.com>
 <alpine.DEB.2.21.1803232036140.1481@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1803232044350.1481@nanos.tec.linutronix.de>
Cc: Shakeel Butt <shakeelb@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linuxram@us.ibm.com, mpe@ellerman.id.au,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <933dac0d-1be4-e952-7f53-0fa6d9169c9f@intel.com>
Date: Fri, 23 Mar 2018 12:48:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803232044350.1481@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 12:45 PM, Thomas Gleixner wrote:
>> The fixes tag makes sense in general even if the patch is not tagged for
>> stable. It gives you immediate context and I use it a lot to look why this
>> went unnoticed or what the context of that change was.
> That said, I'm even lazier than you and prefer you to dig up the original
> commit :)

I'll have these tags in the next repost.

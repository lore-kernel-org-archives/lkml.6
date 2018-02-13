Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934250AbeBMKCs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:02:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:41165 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933691AbeBMKBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:01:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="30353526"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, tcharding <me@tobin.cc>
Subject: Re: [PATCH 5/8] docs: kernel-doc: Move STATE_BODY processing to a separate function
In-Reply-To: <CA+55aFwULB0-ALeQP9jsbW0qbAkiSPnDw3smJEiZqU+VV=QrBg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180207172624.24555-1-corbet@lwn.net> <20180207172624.24555-6-corbet@lwn.net> <877erma4oy.fsf@intel.com> <CA+55aFwULB0-ALeQP9jsbW0qbAkiSPnDw3smJEiZqU+VV=QrBg@mail.gmail.com>
Date: Tue, 13 Feb 2018 12:01:43 +0200
Message-ID: <87y3jxky2g.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Feb 2018, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, Feb 9, 2018 at 1:32 AM, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>> +     # miguel-style comment kludge, look for blank lines after
>>> +     # @parameter line to signify start of description
>>
>> The "miguel-style" always intrigued me, but its origin predates git
>> history. Does anyone know?
>
> It came with the original script in 2.3.52-pre1, somewhere around March 2000.
>
> (Historical footnote: there was no actual 2.3.52 ever released - it
> was supposed turn into 2.4, but there was a long line of 2.3.99-pre
> kernels before that then finally happened early 2001).
>
> But no, back then we didn't track things well enough to have an actual
> reason. And even with git, we probably wouldn't have had a reason
> since it came in the initial patch.
>
> You'd have to go search emails if you really care. That "around March
> 2000" would at least give you a starting point for searches.

Thanks for the background digging! I had a cursory look at the list
archives, nothing much jumped at me but I found that the script was
originally called gdoc. A little googling revealed that other forks of
the script predating inclusion to the kernel also included the comment.

I'll bet whoever added that didn't think someone would wonder about it
two decades later.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center

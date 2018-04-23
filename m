Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755425AbeDWNul (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:50:41 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:41900 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755198AbeDWNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:50:37 -0400
X-Google-Smtp-Source: AIpwx48WHqPKZCZ5XBYM8qiA7T7q+D+l61k/RPF/DgIL/fEmziLXMy847+fyyCI5bAOrCxe3yRqlgPwv4ert+GsJ+pM=
MIME-Version: 1.0
In-Reply-To: <20180423093321.GV4064@hirez.programming.kicks-ass.net>
References: <20180420131407.721875616@infradead.org> <20180423010343.GG16083@dhcp22.suse.cz>
 <20180423093321.GV4064@hirez.programming.kicks-ass.net>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 23 Apr 2018 06:50:36 -0700
Message-ID: <CAPcyv4hEufFemihN8-pRC1sUqSzC9vbK8_s28Vyacd_e7-muow@mail.gmail.com>
Subject: Re: [PATCH 0/7] Various Spectre-v1 fixes
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 2:33 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sun, Apr 22, 2018 at 07:03:44PM -0600, Michal Hocko wrote:
>> On Fri 20-04-18 15:14:07, Peter Zijlstra wrote:
>> > These fix a number of perf, x86 and sched cases where we have user controlled
>> > array dereferences.  All were found by Dan's recent Smatch update.
>>
>> Do we want to mark all of these for stable?
>
> If we all agree that any (speculative) user-controlled array index --
> irrespective of the existence of the second load/store that would
> complete the gadget -- needs fixing and thus all these patches are
> 'good', then yes, that makes sense.
>
> Given yours is the only response so far, I suspect we're good on all
> that :-)

+1 from me for -stable.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeBIUe5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 15:34:57 -0500
Received: from mail.efficios.com ([167.114.142.141]:55193 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIUe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 15:34:56 -0500
Date: Fri, 9 Feb 2018 20:35:45 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1504422181.19125.1518208545731.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180209182530.GB21542@arm.com>
References: <20180206114048.6c8ced1c@canb.auug.org.au> <20180206135512.GB22740@arm.com> <1815310787.16844.1517926010063.JavaMail.zimbra@efficios.com> <20180206141118.GC22740@arm.com> <20180208070350.mxirhg32zljp2e4k@gmail.com> <20180208185637.GB16314@arm.com> <989035723.18493.1518116696482.JavaMail.zimbra@efficios.com> <20180209182530.GB21542@arm.com>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Topic: linux-next: manual merge of the tip tree with Linus' tree
Thread-Index: gbYodJ6A540u7QUVr6SYMvAPLpUNZg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 9, 2018, at 1:25 PM, Will Deacon will.deacon@arm.com wrote:

> On Thu, Feb 08, 2018 at 07:04:56PM +0000, Mathieu Desnoyers wrote:
>> ----- On Feb 8, 2018, at 1:56 PM, Will Deacon will.deacon@arm.com wrote:
>> 
>> > On Thu, Feb 08, 2018 at 08:03:50AM +0100, Ingo Molnar wrote:
>> >> 
>> >> * Will Deacon <will.deacon@arm.com> wrote:
>> >> 
>> >> > For the sake of avoiding the conflict, can we just drop it for now, please?
>> >> 
>> >> Yeah, so I resolved the conflict by merging the (already upstream) bits and
>> >> Linus
>> >> pulled that resolution. From now on the level of comments you want there is up
>> >> to
>> >> you! :-)
>> > 
>> > Haha, ok! Mathieu -- are you still planning to add something under
>> > Documentation/? Regardless of my preference on comments, I think it would
>> > be useful.
>> 
>> I submitted it as RFC a few days ago, and I'm still awaiting feedback:
>> 
>> http://lkml.kernel.org/r/1517936413-19675-1-git-send-email-mathieu.desnoyers@efficios.com
>> 
>> If you guys are OK with the approach, I can submit it again, this time without
>> the RFC
>> tag.
> 
> Yes, please!

Done: https://lkml.kernel.org/r/1518208256-22034-1-git-send-email-mathieu.desnoyers@efficios.com

Let's see what Thomas/Ingo/PeterZ have to say about this approach to documentation.
Ingo, if you are OK with it, this feature documentation patch could go through the scheduler tree.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

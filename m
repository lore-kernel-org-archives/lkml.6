Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBISZ2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:25:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51548 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeBISZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:25:26 -0500
Date: Fri, 9 Feb 2018 18:25:31 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20180209182530.GB21542@arm.com>
References: <20180206114048.6c8ced1c@canb.auug.org.au>
 <750091485.16756.1517921554396.JavaMail.zimbra@efficios.com>
 <20180206135512.GB22740@arm.com>
 <1815310787.16844.1517926010063.JavaMail.zimbra@efficios.com>
 <20180206141118.GC22740@arm.com>
 <20180208070350.mxirhg32zljp2e4k@gmail.com>
 <20180208185637.GB16314@arm.com>
 <989035723.18493.1518116696482.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <989035723.18493.1518116696482.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 07:04:56PM +0000, Mathieu Desnoyers wrote:
> ----- On Feb 8, 2018, at 1:56 PM, Will Deacon will.deacon@arm.com wrote:
> 
> > On Thu, Feb 08, 2018 at 08:03:50AM +0100, Ingo Molnar wrote:
> >> 
> >> * Will Deacon <will.deacon@arm.com> wrote:
> >> 
> >> > For the sake of avoiding the conflict, can we just drop it for now, please?
> >> 
> >> Yeah, so I resolved the conflict by merging the (already upstream) bits and
> >> Linus
> >> pulled that resolution. From now on the level of comments you want there is up
> >> to
> >> you! :-)
> > 
> > Haha, ok! Mathieu -- are you still planning to add something under
> > Documentation/? Regardless of my preference on comments, I think it would
> > be useful.
> 
> I submitted it as RFC a few days ago, and I'm still awaiting feedback:
> 
> http://lkml.kernel.org/r/1517936413-19675-1-git-send-email-mathieu.desnoyers@efficios.com
> 
> If you guys are OK with the approach, I can submit it again, this time without the RFC
> tag.

Yes, please!

Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBHS4f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:56:35 -0500
Received: from foss.arm.com ([217.140.101.70]:39158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeBHS4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:56:33 -0500
Date: Thu, 8 Feb 2018 18:56:38 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20180208185637.GB16314@arm.com>
References: <20180206114048.6c8ced1c@canb.auug.org.au>
 <750091485.16756.1517921554396.JavaMail.zimbra@efficios.com>
 <20180206135512.GB22740@arm.com>
 <1815310787.16844.1517926010063.JavaMail.zimbra@efficios.com>
 <20180206141118.GC22740@arm.com>
 <20180208070350.mxirhg32zljp2e4k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208070350.mxirhg32zljp2e4k@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 08:03:50AM +0100, Ingo Molnar wrote:
> 
> * Will Deacon <will.deacon@arm.com> wrote:
> 
> > For the sake of avoiding the conflict, can we just drop it for now, please?
> 
> Yeah, so I resolved the conflict by merging the (already upstream) bits and Linus 
> pulled that resolution. From now on the level of comments you want there is up to 
> you! :-)

Haha, ok! Mathieu -- are you still planning to add something under
Documentation/? Regardless of my preference on comments, I think it would
be useful.

Will

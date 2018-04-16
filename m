Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeDPVsZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:48:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42814 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbeDPVsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:48:22 -0400
X-Google-Smtp-Source: AIpwx4+dhIeiRsRjO1KSCxFfZhNH21+ebtdi28YewDjXNgc22IXOlgBqO8eIXRHOQkdezZyfyidIoQ==
Date: Mon, 16 Apr 2018 23:48:18 +0200
From: Thymo van Beers <thymovanbeers@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kernel-parameters.txt: Fix whitespace
Message-ID: <20180416214602.GA11295@thinkpad>
References: <20180416154458.GA24716@thinkpad>
 <20180416140846.0effe6ad@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416140846.0effe6ad@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 02:08:46PM -0600, Jonathan Corbet wrote:
> On Mon, 16 Apr 2018 17:45:01 +0200
> Thymo van Beers <thymovanbeers@gmail.com> wrote:
> 
> > Some lines used spaces instead of tabs at line start.
> > This can cause mangled lines in editors due to inconsistency.
> > 
> > Replace spaces for tabs where appropriate.
> 
> Seems like a fine idea.  The patch doesn't apply, though; can you please
> make a version against current docs-next?  (Or against 4.17-rc1 will work
> too).
> 
> Also...
> 
> >  			domain
> > -			  Isolate from the general SMP balancing and scheduling
> > -			  algorithms. Note that performing domain isolation this way
> > -			  is irreversible: it's not possible to bring back a CPU to
> > -			  the domains once isolated through isolcpus. It's strongly
> > -			  advised to use cpusets instead to disable scheduler load
> > -			  balancing through the "cpuset.sched_load_balance" file.
> > -			  It offers a much more flexible interface where CPUs can
> > -			  move in and out of an isolated set anytime.
> > -
> > -			  You can move a process onto or off an "isolated" CPU via
> > -			  the CPU affinity syscalls or cpuset.
> > -			  <cpu number> begins at 0 and the maximum value is
> > -			  "number of CPUs in system - 1".
> > +				Isolate from the general SMP balancing and scheduling
> > +				algorithms. Note that performing domain isolation this way
> > +				is irreversible: it's not possible to bring back a CPU to
> > +				the domains once isolated through isolcpus. It's strongly
> > +				advised to use cpusets instead to disable scheduler load
> > +				balancing through the "cpuset.sched_load_balance" file.
> > +				It offers a much more flexible interface where CPUs can
> > +				move in and out of an isolated set anytime.
> > +
> > +			You can move a process onto or off an "isolated" CPU via
> > +			the CPU affinity syscalls or cpuset.
> > +			<cpu number> begins at 0 and the maximum value is
> > +			"number of CPUs in system - 1".
> 
> This would appear to have changed the indentation of some of the text?
> 
> Thanks,
> 
> jon

Thanks for the comment.

I will rebase against docs-next. Hadn't realised my tree wasn't
up-to-date.

Upon reviewing that section I see that was intentional indentation and
not some tab/space mix up.

Both will be fixed in v2.

- Thymo

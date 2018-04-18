Return-Path: <pmladek@suse.com>
X-Cyrus-Session-Id: sloti22d1t05-4089077-1524040397-2-17090760062336396441
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='195.135.220.15', Host='mx2.suse.de', Country='DE', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: pmladek@suse.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524040397; b=M5tilvvO2p6iEVdmMkVnsOvE7/vyQ+CZ1GLj2Hord0mOyRwMh+
    M7Y8GcbWRb+s4IazPQmwqN2wTRPSanPw46Dmu6+qhBwEOYAeWnSncNeWVNV5Ay9R
    VEjtwof4+xb64xzcsELbWkcOsjN01zRw+GvjBthSzNYgh11oednSgSJPnOMH4MmS
    vF05UFDVr1iPlojWyBXNHv4Akjb9eaYGHdDxDjcoRdz021iUi45g5xsltpo1WFMj
    CdJAcZbTTypfO0vB34IAq7Y240zsKse1f+ORYPMCF9drwZDPeyxNnuhTRNX5LQrS
    Nyta0PhiWI8qs+engMYTBektOeThZH6CfyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1524040397; bh=I93EfxzxDXgjxOlwaM8pdaJb1SaDAacZFjgD8BLc0vY=; b=s
    20rels1IzYis3q+mg6z69/i/DRpXKBywqH3YqHGH4Ln7MP4IqA0t8N30zVPVdrZr
    NwRk85Jk443Ts+Fwb/oJzVuDHQ1VqYb0uwOuQg7W2TbPGmtFzNx37Qp9z1y/VqI8
    T3Mg6kuRWaIvy3vslLZPz3mx5mpsutIg/mjavzcNCRcOgJhxy1VaPIkCkriqrEQg
    mfA3vs1WoaISNzmPcFMguMlvBSigN0LwdWTcbnFrhOLdg/+7daSQspLeFwzVwDXE
    0US0FkOVn38D6yYi41IrwC773UZFSjmyiEg5ire0sJ3Ry4RrbxSaNdhIBTa8BMuA
    JPq/7730oEMlzNkXF+/hw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=suse.com;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=pass smtp.mailfrom=pmladek@suse.com smtp.helo=mx2.suse.de;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=suse.com smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=suse.com;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=pass smtp.mailfrom=pmladek@suse.com smtp.helo=mx2.suse.de;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=suse.com smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfELAJm+DlZ53r01Ptk7hynAthm3xBsZyRnnGowm+1DcyhCq0T5jPTFBpIguEf5H9mBl/yuiZh28bqglLYS44+9jYAl6WqV88nCTH01ZITMBo0m0mR8oE
    kGdOAktApVMPszlmS8isNxMjm8Uzzbf0mc3csYVYU2Tzasx0Z2JxysNs1am6HdIf+Uqe2VPckDjPLA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=uEuDQZVrWKuLCe7byFjfVg==:117
    a=uEuDQZVrWKuLCe7byFjfVg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=zYH47tmTkgRG0YhIKTgA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Date: Wed, 18 Apr 2018 10:33:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180418083309.kbrnhfb245tt5si7@pathway.suse.cz>
References: <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
 <20180416122244.146aec48@gandalf.local.home>
 <20180416163107.GC2341@sasha-vm>
 <20180416124711.048f1858@gandalf.local.home>
 <20180416165258.GH2341@sasha-vm>
 <20180416170010.GA11034@amd>
 <20180417104637.GD8445@kroah.com>
 <20180417122454.rwkwpsfvyhpzvvx3@pathway.suse.cz>
 <20180417134557.GT2341@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417134557.GT2341@sasha-vm>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 2018-04-17 13:45:59, Sasha Levin wrote:
> On Tue, Apr 17, 2018 at 02:24:54PM +0200, Petr Mladek wrote:
> >Back to the trend. Last week I got autosel mails even for
> >patches that were still being discussed, had issues, and
> >were far from upstream:
> >
> > https://lkml.kernel.org/r/DM5PR2101MB1032AB19B489D46B717B50D4FBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com
> > https://lkml.kernel.org/r/DM5PR2101MB10327FA0A7E0D2C901E33B79FBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com
> >
> >It might be a good idea if the mail asked to add Fixes: tag
> >or stable mailing list. But the mail suggested to add the
> >unfinished patch into stable branch directly (even before
> >upstreaming?).
> 
> I obviously didn't suggest that this patch will go in -stable before
> it's upstream.
> 
> I've started doing those because some folks can't be arsed to reply to a
> review request for a patch that is months old. I found that if I send
> these mails while the discussion is still going on I'd get a much better
> response rate from people.

I see. It makes sense.

> If you think any of these patches should go in stable there were two
> ways about it:
>
>  - You end up adding the -stable tag yourself, and it would follow the
>    usual route where Greg picks it up.
>  - You reply to that mail, and the patch would wait in a list until my
>    script notices it made it upstream, at which point it would get
>    queued for stable.

It would be great if the options are described in the mail.

I wonder if it would make sense to add also a tag that would
say that the commit is not suitable for stable. It might
help both sides. The maintainers will be able to share
their opinion and eventually reduce mails from autosel.
You would get feedback that maintainers considered
the patch for stable. It might be even useful for
teaching the AI.


> >Now, there are only hand full of printk patches in each
> >release, so it is still doable. I just do not understand
> >how other maintainers, from much more busy subsystems,
> >could cope with this trend.
> 
> So yes, I'm aware that the volume of patches is huge, but there's not
> much I can do about it because it's just a subset of the kernel's patch
> volume and since the kernel gets more and more patches each release, the
> volume of stable commits is bound to grow as well.

Yes, but the grow in the stable is much faster than the grow
in maintain at the moment. It might be fine if it was caused
just by engaging subsystems that ignored stable so far. But
I am not sure if it is the case. Also I am not sure about
your plans.

Anyway, I am surprised that the patches might go into stable
so easily (no response -> accepted). While it is pretty
hard to get through the review process for mainline.

Of course, many patches go into mainline without review
as well. But the difference is that they are pushed by
people that are familiar and responsible for the affected
area.

I could understand the pain. There are surely people that
do not care about stable, because it takes time, it is hard
to make decisions, flashbacks to the old code are painful,
etc. Well, this is the reason why the maintenance support
is and should be limited.

Anyway, I think that it cannot be done reasonably without
maintainers. You should be careful so that even the currently
cooperating maintainers will not start considering autosel
mails as a spam. (It is not my case. printk is small thing.
But I could imagine that it might stop being bearable
in bigger subsystems. As is already the case with xfs.)

Best Regards,
Petr

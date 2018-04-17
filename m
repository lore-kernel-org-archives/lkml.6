Return-Path: <jikos@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1636556-1523964087-2-2270597988107454903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_MED -2.3, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='195.135.220.15', Host='mx2.suse.de', Country='DE', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: jikos@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523964086; b=uXo5r3XBFdXFfxBiTjXhAVvFnrrOhxRaW/6zSEmDTpwkmOPDXb
    3UNEwmDYBvSxjYcRNnREGfm8q/jqVwNvQHpWJSTYJIvqynm/14ByEO8g2j7tbyDz
    707j7VhuwqcbEomiobAVmhzOjMkWFFKSlUOPAbczxn1x+qXwgCmEYB3ECqJKV6v1
    +s8u09Nv3Mg/ZcgoyvWqo+jFA/DeC6MY1DFP7r96ErgAQHXk+PNXjo+4eDRuEZ6+
    sWHYHbHLIDKWJxsQGh/bZH//FWJBUYtxLcNGltapulYcXvPZRg9J0WaSB1ejwPc+
    jav7C/jp3+onX7ebERpc6H8A1N1L1x0ObRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type; s=fm2; t=
    1523964086; bh=mkGJWRgV1v4uQkfh0cf/hOU2kfr+xqNF2tJo/RreTYA=; b=v
    L1+R+Ixxi6nbC7P1rr1tkRWyyiWe0B1Q4oOgDV1S4F/LmyxlPlCQeBX8cZfBin1W
    cHNtOhToBNgSAOMcv4M7ePlkjgnTrOfUNlL/X7e/y2ulN8wUNT9IcZrqsvSQCBVp
    LgTZbe7TneNJ7PL0+3lU6ywV7U1VIvYnmdRq1b+q89R/gPpzEAJqRsDRaY8YjEbu
    R2imYdNcrqwpExKGBZFSgKzpOTMImbBY+pDuxsXp9UC86fWvyf6bs10BsDrjq7HS
    YL4ktNrEHNogH4Ep1QHVy7tf9z6hCruN8sbri9FY4F9bC3kjrIplJuaGqvLJbhzF
    EAFgBXe5Cjr+h7Q8eL0XQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=none smtp.mailfrom=jikos@kernel.org smtp.helo=mx2.suse.de;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=none smtp.mailfrom=jikos@kernel.org smtp.helo=mx2.suse.de;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKh4sEY8HVofiUuzfggbxXOAfvU6pRI8kFie7U7nnnODcY5Zq3LJmd5o50U+KFkMbNkr8JCj/emBHb1Z2hvdMvJMgf3Tc6EGse9bAFUUuNn+JfzmkWgt
    11C49PkAogvqD2XwD8PLMnV3UhsyFXbuMrB6sgz0M0NeUfIzGlBZkLijsGRUCwMZ28Pjgop0bToaAg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=uEuDQZVrWKuLCe7byFjfVg==:117
    a=uEuDQZVrWKuLCe7byFjfVg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=e7cu5d_3Oq7_yF9kUhMA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Date: Tue, 17 Apr 2018 13:21:21 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Greg KH <greg@kroah.com>
cc: Sasha Levin <Alexander.Levin@microsoft.com>, Pavel Machek <pavel@ucw.cz>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
    "stable@vger.kernel.org" <stable@vger.kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
    "linux-mm@kvack.org" <linux-mm@kvack.org>,
    Cong Wang <xiyou.wangcong@gmail.com>, Dave Hansen <dave.hansen@intel.com>,
    Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
    Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
    Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
    Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
In-Reply-To: <20180417103936.GC8445@kroah.com>
Message-ID: <nycvar.YFH.7.76.1804171250270.28129@cbobk.fhfr.pm>
References: <20180416155031.GX2341@sasha-vm> <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm> <20180416170501.GB11034@amd> <20180416171607.GJ2341@sasha-vm> <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm> <20180416203629.GO2341@sasha-vm>
 <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm> <20180416211845.GP2341@sasha-vm> <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm> <20180417103936.GC8445@kroah.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 17 Apr 2018, Greg KH wrote:

> It already is that :)

I have a question: I guess a stable team has an idea who they are 
preparing the tree for, IOW who is the target consumer. Who is it?

Certainly it's not major distros, as both RH and SUSE already stated that 
they are either not basing off the stable kernel (only cherry-pick fixes 
from it) (RH), or are quite far in the process of moving away from stable 
tree towards combination of what RH is doing + semi-automated evaluation 
of Fixes: tag (SUSE).

If the target audience is somewhere else, that's perfectly fine, but then 
it'd have to be stated explicitly I guess.

I can't speak for RH, but for us (at least me personally), the pace of 
patches flowing into -stable is way too high for us to keep control of 
what is landing in our tree.

In some sense, stability should be equivalent to "minimal necessary amout 
of super-critical changes". That's not what this "let's backport 
proactively almost everything that has word 'fixes' in changelog" (I'm a 
bit exaggerating of course) seems to be about.

Again, the rules stated out in

	Documentation/process/stable-kernel-rules.rst

are very nice, and are exactly something at least we would be very happy 
about. They have the nice hidden asumption in them, that someone actually 
has to actively invest human brain power to think about the fix, its 
consequences, prerequisities, etc. Not just doing a big dump of all 
commits that "might fix something".

How many of the actual patches flowing into -stable would satisfy those 
criteria these days?

IOW, I'm pretty sure our users are much happier with us supplying them 
reactive fixes than pro-active uncertainity.

> The problem Sasha is trying to solve here is that for many subsystems,
> maintainers do not mark patches for stable at all.

The pressure on those subsystems should be coming from unhappy users 
(being it end-users or vendors redistributing the tree) of the stable 
tree, who would be complaining about missing fixes for those subsystems. 
Is this actually happening? Where?

> Oh, and if you do want to complain about huge new features being 
> backported, look at the mess that Spectre and Meltdown has caused in the 
> stable trees.  I don't see anyone complaining about those massive 
> changes :)

Umm, sorry, how is this related?

There simply was no other way, and I took it for given that this is seen 
by everybody involved as an absolute exception, due to the nature of the 
issue and of the massive changes that were needed.

Thanks,

-- 
Jiri Kosina
SUSE Labs

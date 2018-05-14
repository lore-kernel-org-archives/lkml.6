Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-460432-1526285572-2-1769229033214610382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526285572; b=W+2q7UQvk6R4DfjDZwFAu9M/PMrEpuNuGh2IggTXtuS4IzkUJv
    udAA0keGwqM0YNb2rReRAibqPkcYJUsAoE8ujxDO2HYNmhd1BUFQy6EjDVBqIRx2
    NPBuHZiFuJ+BdIEe+SjnPRx/UZ0BawS0D8nee74tZh+u5LNgU1IbnejM9+u5RniC
    5Fr8uLt49yF/jtElW5t5JlnOamT2eOmffJ5yqZTWoZ+FrslOSg5l8yyIOyHOh9Nm
    CBLTSTYWqfWIlM/cgfcdXkVlhiig6B9DSTyUJlt3DmoaSbZikd7fGl4Ur3yFczUX
    pe1QEiG53wzWiuC4kPzdVnHssil1Bh94KktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526285572; bh=HAmYN
    T9xA/2GygCv24kWSLud5mWjgHFiNz6ycewdlCo=; b=POVH8piuiSoVJ1AqQUr6o
    3LpOrTXO1ktREX9UkYe60tCsCvPd+SSdVxtc3knYJePPJIbMZ/uyjYhe5OvVCF9/
    KdrezGoulMyKqWbe7kdtBSDC5GC4+e1BsgcDP7ghFzEdt8w09RtT0Y++5x1iW7mk
    i6IE8KExXUHUmAOFtY2gwyDzw+B3CWzbcifr7MDeCFsSYZU/YjEm/hME+QyZ3fA5
    t4wNzQCIwiGSMGBgulGA15lggXB85b0t3UMygRcK2R+HPeroZeIlCYKkdmLwdT7f
    FbJSPcPeF5Kz4xw5PzVx+rV/vuhtPm98bPZAZ1qpnZzoH3jixymtQCdI+ivex3mj
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=bootlin.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=bootlin.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI0IVrVsugqQ1MG5re8R/Ozk0Agvb+rfuCwJLPfXHxKIvLYF/eEVQ/dbwdZ8XFb6VGZwttm79bJ/KV7PSAQqbnGJYBRF9HmJRGuLwV1FUPZbXRMwz2rW
    NaTCyjIXlra/7V16Lin1UZZ18wzFPLEOVupGavcTsoGdsRCmVfs6ERgkKxL7rwC2VO9NBvdfq/SZDj9OXXgGp5tNtc95/E80irWLivJqAGKJk+E3ePZmF8Yc
    yrgrpycqKStYLoR8UMh0Yw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=yMhMjlubAAAA:8
    a=07d9gI8wAAAA:8 a=ag1SF4gXAAAA:8 a=b2RJ4TRWfEuBCW9GwKIA:9
    a=miHagS1hSC2Ll7Qz:21 a=FEKnWoJA12h7dRJS:21 a=CjuIK1q_8ugA:10
    a=Oj-tNtZlA1e06AYgeCfH:22 a=e2CUPOnPG4QKp8I52DXD:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE
	autolearn=ham version=3.3.1
Date: Mon, 14 May 2018 10:12:37 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20180514101237.5df1e0d7@bbrezillon>
In-Reply-To: <CAMuHMdUHK=kmJB-=G-Y7YEneZityMzi5YZ3nJFD6uCs61bOaiQ@mail.gmail.com>
References: <20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<nycvar.YFH.7.76.1805101802150.27054@cbobk.fhfr.pm>
	<20180510164722.GH8514@sasha-vm>
	<CAMuHMdWDNjsba29id4Svjy_tauKivWDUixub3qf82Nx_6rYueA@mail.gmail.com>
	<CAMuHMdUHK=kmJB-=G-Y7YEneZityMzi5YZ3nJFD6uCs61bOaiQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 10:00:30 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Tue, May 1, 2018 at 10:00 PM, Sasha Levin
> <Alexander.Levin@microsoft.com> wrote:
> > On Tue, May 01, 2018 at 03:44:50PM -0400, Theodore Y. Ts'o wrote:  
> >>On Tue, May 01, 2018 at 04:38:21PM +0000, Sasha Levin wrote:  
> >>>  - A merge window commit spent 50% more days, on average, in -next than a -rc
> >>>    commit.  
> >>
> >>So it *used* to be the case that after the merge window, I would queue
> >>up bug fixes for the next merge window.  Greg K-H pushed for me to
> >>send them to Linus sooner, instead of waiting for the next merge
> >>window.  TBH, it's actually easier for me to just wait until the next
> >>merge window, but please understand that there are multiple pressures
> >>on maintainers going on here, and the latest efforts to try to use
> >>AUTOSEL is just the most recent pressure placed on maintainers.
> >>
> >>The other thing is that when there is a regression users who are
> >>testing linux-next want it fixed *fast*.  That's considered more
> >>important to them than waiting for one, perfect patch, just to keep
> >>AUTOSEL happy.
> >>
> >>So please understand that when you say that maintainers *need* to do X
> >>or Y, that there you are not the only one standing in line putting
> >>pressures on maintainers saying they *need* to do something.  And
> >>quite frankly, I consider keeping people who are nice enough to test
> >>linux-next happy to be **far** more important than AUTOSEL.  
> >
> > Ted,
> >
> > I'm not at all asking to wait before adding the patches to your tree,
> > or to -next. I'm asking to hold on to them a bit longer before you
> > push them to Linus because I can show that patches that don't spend
> > enough time in -next are more likely to introduce bugs.
> >
> > Yes, linux-next users want it fixed *now* and I completely agree it
> > should be done that way, but the fix should not be immediately pushed to
> > Linus as well.
> >
> > I've just finished reading an interesting article on LWN about the
> > PostgreSQL fsync issues (https://lwn.net/Articles/752952/). If you
> > look at Willy's commit, he wrote the final version of it about 5 days
> > ago, Jeff merged it in 3 days ago, and Linus merged it in the tree
> > today. Did it spend any time getting -next testing? nope.
> >
> > What's worse is that that commit is tagged for stable, which means
> > that (given Greg's schedule) it may find it's way to -stable users
> > even before some -next users/bots had a chance to test it out.  
> 
> I just noticed a case where a commit was picked up for stable, while a
> bot had flagged it as a build regression 18 hours earlier (with a CC to
> lkml).

Also, this patch has been on a tree that I know is tested by Fengguang's
robots for more than a week (and in linux-next for 2 days, which, I
agree, is probably not enough), and still, I only received the bug
report when the patch reached mainline. Are there tests that are only
run on Linus' tree?

> 
> So it looks like the script for backporting commits should be enhanced to
> check for this (searching for the commit ID in my email archive found the
> bot report).
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-457733-1526284849-2-4443232840007625910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526284849; b=ftMXpZ7KOi7JtymVkc22FnNhHRT0wP42ZavjfM1W7bxIaRZljQ
    QBExb+dL2uiw+uyPS2rFiQpKx2C5XY7mwvjDy5PdYk7QYYnAAGYwmCR3mNrriiMC
    f88TE6jBTMsJn2DmBxX0VJCE05g9RPlQnsuVXYnQJNQVK1B+Lgz2Bqg24pwzFpPB
    oEe1pqM7PwzGH5ziZTlsyIr4PLInA2xTupcCxc/xyWSzPMIWN9mLSTiCD4nzekZl
    AU7cXfP7A8CZaLcSM7jXa/Q50VWMAZu5pNIVcZygY1eWSZ3vBxWsK/O2gc1+x12a
    uqUQk5g/NIwWIMlxhGrOda1rqQ8Tldr93FoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526284849; bh=F46B0
    WdEj4Yrmk37MXyaXSvgf20zha+xCQjb25WUzBA=; b=A5vTrVDt0dLzFYd9uDOMX
    H3OO2IEyT1Tdmy4nCWLkkmwyl0BrueIDWJZ/GWlts0A9LiDxnWRpBZF1vW10dUI8
    j4auwt7olIcueTcE96G7UlL2Htk9yM1/V5IxUjQz2+g/AcrxiJU+BmRkaswfoIsd
    9eFJb7UqwQ/g09RU66HUD1kGgHb3RU6SsY3YO0Kxe+9zhk0sC7hjYMfgD5hqEtC3
    VNMwW8nb8S8kV7+KVSMQ+TtZ9K5pC6JeiG7w2ko2WZAAED8OilzTzO8iDC8oWmnF
    PPtuW5o5hyEixLG0hoGI/YltbeywSgO0Tyom2Ao9WXwgmQAHoBcXYgC+83iyEuhV
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=OJbUFebl x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=HlUUmHe1;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=OJbUFebl x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=HlUUmHe1;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMxlfwvTMzAy31pit80QnCBKp1hrzW8gpZAie6O4lIT7oA6jngoDzSAAL2j7APjPqReCVGY4a8mj2ov7Z/7GPoka1hf37MQUHO2ZMZJToJanLWUae4Ww
    MOL1S+XM1CVn2SxJYRRR5KRPDL35wzDSCFwyhMINJq/9K4hskx3AsehQ6jiK03CRiOdwKN+T27scjIgOO5ATMgHBI94/sQPInlg6EIn7UQnTyImpScqJBb7C
    5BFDrT8rjKHcDrbpW5cuSg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=07d9gI8wAAAA:8
    a=tBb2bbeoAAAA:8 a=ag1SF4gXAAAA:8 a=J08iiUO3UqFeIJMw_-UA:9
    a=V-hPLBU8PLYA7v1S:21 a=lwulGa-7TnRoNCsT:21 a=CjuIK1q_8ugA:10
    a=e2CUPOnPG4QKp8I52DXD:22 a=Oj-tNtZlA1e06AYgeCfH:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZrGlWDY8A2zvSO+2tZ/RafUcisz5rBAg1hVQ6VERVCokMld8xh1vpMNr2NkFYllyCbGHUmVRw5/y8lor+v8kVM=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWDNjsba29id4Svjy_tauKivWDUixub3qf82Nx_6rYueA@mail.gmail.com>
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
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 10:00:30 +0200
X-Google-Sender-Auth: x0ZM2ExNKWVEz32myW3TgGas6g0
Message-ID: <CAMuHMdUHK=kmJB-=G-Y7YEneZityMzi5YZ3nJFD6uCs61bOaiQ@mail.gmail.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>
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

On Tue, May 1, 2018 at 10:00 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> On Tue, May 01, 2018 at 03:44:50PM -0400, Theodore Y. Ts'o wrote:
>>On Tue, May 01, 2018 at 04:38:21PM +0000, Sasha Levin wrote:
>>>  - A merge window commit spent 50% more days, on average, in -next than a -rc
>>>    commit.
>>
>>So it *used* to be the case that after the merge window, I would queue
>>up bug fixes for the next merge window.  Greg K-H pushed for me to
>>send them to Linus sooner, instead of waiting for the next merge
>>window.  TBH, it's actually easier for me to just wait until the next
>>merge window, but please understand that there are multiple pressures
>>on maintainers going on here, and the latest efforts to try to use
>>AUTOSEL is just the most recent pressure placed on maintainers.
>>
>>The other thing is that when there is a regression users who are
>>testing linux-next want it fixed *fast*.  That's considered more
>>important to them than waiting for one, perfect patch, just to keep
>>AUTOSEL happy.
>>
>>So please understand that when you say that maintainers *need* to do X
>>or Y, that there you are not the only one standing in line putting
>>pressures on maintainers saying they *need* to do something.  And
>>quite frankly, I consider keeping people who are nice enough to test
>>linux-next happy to be **far** more important than AUTOSEL.
>
> Ted,
>
> I'm not at all asking to wait before adding the patches to your tree,
> or to -next. I'm asking to hold on to them a bit longer before you
> push them to Linus because I can show that patches that don't spend
> enough time in -next are more likely to introduce bugs.
>
> Yes, linux-next users want it fixed *now* and I completely agree it
> should be done that way, but the fix should not be immediately pushed to
> Linus as well.
>
> I've just finished reading an interesting article on LWN about the
> PostgreSQL fsync issues (https://lwn.net/Articles/752952/). If you
> look at Willy's commit, he wrote the final version of it about 5 days
> ago, Jeff merged it in 3 days ago, and Linus merged it in the tree
> today. Did it spend any time getting -next testing? nope.
>
> What's worse is that that commit is tagged for stable, which means
> that (given Greg's schedule) it may find it's way to -stable users
> even before some -next users/bots had a chance to test it out.

I just noticed a case where a commit was picked up for stable, while a
bot had flagged it as a build regression 18 hours earlier (with a CC to
lkml).

So it looks like the script for backporting commits should be enhanced to
check for this (searching for the commit ID in my email archive found the
bot report).

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

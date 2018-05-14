Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-436143-1526284444-2-2266062189529915993
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
    1526284443; b=ZMtQ1hSZ4VaPaXvRCxrqo+PYN8aR7bur9GQEygVn0gW2KX8fYx
    /a+06HZZwfk83rQO4D1G37+7p+lxwRY2EglLFe8cDpgiRdcNAdLt0H/ORMI3Kplq
    aBRl0utQfLFXsgcMDWUhmVqWsUkR5CfWdCAxSH1knt99lRc3UTrYuyFH3UtHk61Q
    Dt2PO8ep06QagTUBgb0IFYTE7iD5s+c7ebSaKFdD9Rmh87jewVXHqjhAD1Q+cxO1
    dimqTkr25fnO+fxAPAFTb2FBsqTZe4IydgXukr92eHpB/jCt+HNZpoyZX/KmPYFU
    BSXiqrdaywNoS/Xqq6YQ80cB3xDxwZcG8K4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526284443; bh=UlmmJ
    HEOxQ3AQvK+j8C2FWHlM4Sm+Us2q7zrnHD7D7w=; b=d/EdFJCDYVbQj9ru4jqHC
    6hZPRI0T+f60eCFzy00RBS2oV2ACNMYWv9DQKWi7haC2mO6QMsk1Px1m7oDQtmMH
    auiM1H7xlQszRDYh6FCfarTv5w1MMHXX1qfTpDPTTvY92BwU7K+SBmh9fVqUnBYj
    2XypEzEZKXcfzasfjQZQPsmI8nk4kbzpMKZaRo5UdceP4I6cgghE22eE0nwwmfie
    XIZMaJfB0FeNCKy4gp3mLD5U96RnpEV9cf5HzDYO8V/UZRJ6Q1AUIceCCCBcmeT8
    BEssKteEx8aLpUs7VYHp/RPVVQpqpz4v+UmZJaEAowhni8hlh/TKfAB09B+nvoxU
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=FD49KJcQ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Gu5XQg5l;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=FD49KJcQ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Gu5XQg5l;
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
X-CM-Envelope: MS4wfAP0bIGOn70LEKHX3jNg+wOHWJ3eBlsR60UuYNJw6ae8wiP6SR65vXk6X9ndnbiu8kIai7JX+p5+Ifja+ctuwlZkpAymVamgMGyQPkJh/CMk3PIzQ3+L
    O/87sVst88GIY+ANFmyih/kVSBkqQ+RsucloNGUQ2+kD8sJ8aPSg9DvyG2ObKBdLD7KLUpcHDXvGJehoWncyQYoVPCXIhtW0ENx3hQ8D/8HyG205rNTsOWOU
    pY3E5h36rslMLV1Arx6rCA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=OLL_FvSJAAAA:8
    a=tBb2bbeoAAAA:8 a=ZYS5oAN53p8GJM-4HmsA:9 a=CjuIK1q_8ugA:10 a=j4zAYfkPPL4A:10
    a=uBbYtLA2G74A:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=oIrB72frpwYPwTMnlWqB:22
    a=Oj-tNtZlA1e06AYgeCfH:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZoz5+iwAkzACV7MfbojvYIF6RDlzF1YGoVP7Lt0DbwdXx2hgMVP1Ry2con84nddExXWrFyWuq2rZaep1ePxSvM=
MIME-Version: 1.0
In-Reply-To: <20180510164722.GH8514@sasha-vm>
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
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 09:53:38 +0200
X-Google-Sender-Auth: H7J244_gI0gLFERD4E-_DPNg1JI
Message-ID: <CAMuHMdWDNjsba29id4Svjy_tauKivWDUixub3qf82Nx_6rYueA@mail.gmail.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, May 10, 2018 at 6:47 PM, Sasha Levin via Ksummit-discuss
<ksummit-discuss@lists.linuxfoundation.org> wrote:
> On Thu, May 10, 2018 at 06:03:22PM +0200, Jiri Kosina wrote:
>>On Wed, 9 May 2018, Daniel Vetter wrote:
>>> >> Then, why don't we have a pre-integration tree for fixes? That would
>>> >> at least simply automated testing of fixes separately from new
>>> >> material.
>>> >
>>> >> Perhaps this has already been discussed, and concluded and it's not
>>> >> worth it, then apologize for my ignorance.
>>> >
>>> > I think this is an excellent idea, copying in Stephen for his input.
>>> > I'm currently on holiday but unless someone convinces me it's a terrible
>>> > idea I'm willing to at least give it a go on a trial basis once I'm back
>>> > home.
>>>
>>> Since Stephen merges all -fixes branches first, before merging all the
>>> -next branches, he already generates that as part of linux-next. All
>>> he'd need to do is push that intermediate state out to some
>>> linux-fixes branch for consumption by test bots.
>>
>>What I do for my trees is that I actually merge the '-fixes' branch (that
>>is scheduled to go to Linus in the 'current' cycle) into my for-next
>>branch as well.
>>
>>This has the advantage of (a) getting all the coverage linux-next does (b)
>>seeing any potential merge conflicts early
>>
>>Is this not feasible for other trees?
>
> When Linus tags -rc1, -next will start filling up with commits destined
> for the next merge window. The resulting -next tree becomes very
> unstable, and very difficult to test.
>
> The idea behind next-fixes is to provide a tree that will contain fixes
> for the current merge window, which will generate a much more stable
> tree that users/bots could actually run and validate the fixes that will
> be merged in the upcoming weeks.
>
> Right now, with the method you've described, there is no easy way to
> test your '-fixes' branch even though the commits in there will be
> pulled in by Linus much sooner than your 'for-next' branch.
>
> You'll still get the same coverage from -next, but if you provide your
> -fixes branch seperately you'll also get more coverage for the fixes
> you're about to send to Linus.

I think you missed the "as well" in Jiri's response.

When I create the bi-weekly renesas-drivers release (see e.g.
https://www.spinics.net/lists/linux-renesas-soc/msg27350.html), there are
some subsystems that manage to have several conflicts between their
for-next branch and their fixes in Linus' tree almost every single release.
Hence I strongly support merging your own fixes branches into your own
for-next branch, and resolve the conflicts yourself, to keep your for-next
branch conflict free.

(Note that the last release linked above was very atypical: it was one of
the very few (first one ever?) that didn't have any conflicts).

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

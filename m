Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-219062-1525443696-2-8559085051522730557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525443695; b=T2r+qpoEAG5YiNAyJdCpGFDHBgsxJA6262rJMUijhghE4hf9zA
    XYRuWbOvnTW+azwQ6jqB1LUZGhqgB10OjgoXjJP71EjsMYWuVjIFqyHpsnAupfVi
    1hOfUG7y/XYF/oE4Dd4zJQv8uH7UiXeh/ZNLdnEjDvHgU33htKpIhQDPnAt5zNUv
    RYp8soxmExHrAXimTklzJHCUlULlPuSYU3N+TcZ8ke2n8kqhK5UV5LWoERsKBtUi
    ganTcLyCz2JH7PaQcEI60iskLxRHDbfcdBeU1B3IR7CJOnf6L8mILACONlLFJmiq
    ItewJVSJ2iNw639D5MNfWdyFC2L5RRh1KHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525443695; bh=hKybJ
    7dLYrMSHk3nccOV7BFePTXu9OfCK/cRRnbmrcI=; b=GBK6pP4Da+RN61qZZvtcN
    L/qTIYWQrzr0OnqqIYuTn2/E/+Jf6tRcFhL+dbOaI2+JxEFmRTSyVCNddM9PoErp
    f7I+AbpO/p8RSR+nVbK7RxvAV/ZNG+aYREb0OTJzC2cityKjuXevPkjv8+LVjBdy
    Ga77HXCODXoNmWbUrlXlQoZN5TROHwl7AVC2MOLu16JLNgfpeKLblCB+SVyJifAg
    rO8IM5v5oOsOstmYoMT+6RPSTRf8Dis+VqoR+h12hW7wOmJcyZujpL1BCWjIt11t
    snlZifJiiWx2dgjFavu9a3T5WQ6Scg8gPt0viqIvL3tyElV4WttENbH1spiPAat/
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=PE1NOZCK x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Hb65nP6s;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=linaro.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=PE1NOZCK x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Hb65nP6s;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=linaro.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMRgjvWsqs2SJ7Qj7pn+o7A337gI3+iIk9kNM7dE5+zIwCYzEBvG3wIqQ9th9OgPYRvy/4puQuWvIdbeQpY1E62DCTEnyZL8QivA6bVFyMVDvAEpMoqV
    8//xhgWnEBVRyLhGxutld/mOecqvE7Do6frB+GbWLpvF4GB3HD0JvHsQVwkXMPAtV3yQcjfAifrmlot9R0+vfZ5stwJ6Jn1dUX/6xIgfyJQK2O6c/uXctoqu
    1P/IqzuwazCNfx2CPFFfag==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=2KMo9-giAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=LNfROKWcUvg_0AztHkoA:9 a=NzoPG4dH6WkfrG-S:21
    a=UK71V69cvtCYGf3l:21 a=CjuIK1q_8ugA:10 a=UeCTMeHK7YUBiLmz_SX7:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZrPpWpTkj4qvJKvDS+XrpcbmiNKXl2nwr1cCYIUKaHOfu+fh5YjJcNPyLNP6PIyoF/YfM7pGcy8rtgfDp1KbrY=
MIME-Version: 1.0
In-Reply-To: <20180503230905.GA98604@atomide.com>
References: <20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
	<20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 May 2018 16:21:26 +0200
Message-ID: <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
To: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>,
	Sasha Levin <Alexander.Levin@microsoft.com>
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
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

Tony, Sasha, Mark

On 4 May 2018 at 01:09, Tony Lindgren <tony@atomide.com> wrote:
> * Mark Brown <broonie@kernel.org> [180503 22:44]:
>> On Wed, May 02, 2018 at 08:52:29PM -0700, Guenter Roeck wrote:
>>
>> > As for -next, me and others stopped reporting bugs in it, because when we do
>> > we tend to get flamed for the "noise". Is anyone aware (or cares) that mips
>> > and nds32 images don't build ? Soaking clothes in an empty bathtub won't make
>> > them wet, and bugs in code which no one builds, much less tests or uses, won't
>> > be found.
>>
>> You've been flamed for testing -next?  That's not been my experience and
>> frankly it's pretty horrifying that it's happening.  Testing is pretty
>> much the whole point of -next existing in the first place so you have to
>> wonder why people are putting their trees there if they don't want
>> testing.  I have seen a few issues with people reporting bugs on old
>> versions of -next but otherwise...
>
> Yes I agree testing Linux next is very important. That's the best way for
> maintainers to ensure a usable -rc1 after a merge window. And then for
> the -rc cycle, there not much of need for chasing bugs to get things working.
>
> Bugs reported for Linux next often seem to get fixed or reverted faster
> compared to the -rc cycle too. I think that's because people realize that
> their code will not get merged until it's been fixed.
>
> So some daily testing of Linux next can save a lot scrambling after the
> merge window :)
>
> Users don't usually upgrade kernels until after later -rc releases or only
> after major releases so that probably explains some of the -rc cycle fixes.

I fully agree with above, linux-next works very nicely as a
pre-integration tree, however for *both* fixes and new material.

I guess the concern here is about getting more confidence about pure
fixes, before they hit Linus' tree or any other stable tree. Although
without having to introduce delays or additional work for maintainers
etc.

Then, why don't we have a pre-integration tree for fixes? That would
at least simply automated testing of fixes separately from new
material.

Perhaps this has already been discussed, and concluded and it's not
worth it, then apologize for my ignorance.

Kind regards
Uffe
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

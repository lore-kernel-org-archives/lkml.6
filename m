Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2371419-1525968214-2-16276078700759129068
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
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
    1525968214; b=l4FK+h++CEcPDfsHJsqTqKD75hVgcl2DwP2/IkuR2yxe3JDi9w
    vlr8/jjCD7p1rj+ftOKMHMqWZDcb67m5BAG30VySv4juxECpuVcc0sgx8kTPuJsv
    wuTwCvdpi1XApDdYqDrqZW8giM6DMMnQzUj/kjiHDcl939qzu9VBNpqWqbWZ1hCm
    Qxq9y+0LCJuXU1GGn3/PzyanHgx/e6IlNfU2ezbhdsLHGQlTLxGvZnZrBgfHG1oa
    TLDW0FAxuZiiw6moILY83uFNoX/AmhOK60bvH/JZLNEQ+42ttSTl5Nks5vW3ZeFm
    zSiQWJxzTA20KtxvPhUz+fq7XbbYZMYvWsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:in-reply-to:message-id
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525968214; bh=Qhpjb
    r6lfngtjRxPHLpgVTL7fBp2TjRgLoOP4euu67U=; b=UY21/n186BHnMlfwwJ6k7
    ECxFf2eXKGJ9mCGWtNjk1DI5MZt2455gK4nxmnuUeN3P33IbEE4hq3e/wNxwhvZQ
    FSB9OlhAS/K2PpJk/Um3gD35ZZoHQkghUUaEJ8vi1Rlw2AVXR45r5c8lZDJ42rkS
    eemInVS3AKeLvRFWF2oAk56V+6YxKIA66rEsePzFNx3iLUzKbN21IasqbyxKs7Kt
    n84xBWHpof7cLHxa+ISTYEaU4TsMWNRya+ObiBMLfbO1LEHUL23EVKCVzUKdhqjh
    7PmJb39EWRc6NRPiGshJ2KI7ffBFYLzaAb68X3AKey71G9vh5/YvL9pcxoN+5R54
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=spam score=100 state=1
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=spam score=100 state=1
X-ME-VSCategory: spam
X-CM-Envelope: MS4wfK5tylAyjpsoTpGUmWQ2GNAIh7i3g7mlz9SFVfZ5S4/jZ4dcZZZ19jdxIiDf2f540lD+XKVyEjBh4hTnRslGf2YxvtAoKLSm09/0h23oWGhcI4IT93vo
    rD8WQipSz41SxzhsWoVEyEhf9Mje7cJ53LE356Tq6BCfwRxVppbOzzL0xL06TJdJ4gwlNkO21hUX7ZPyLoLu7Eo4M3Ein9VY9KVoTg3DEpnIZwejyQXXKDrd
    yRx+evvwcZNBk1piCTFloQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=pjUKlATG2KA5Siub0D0A:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Thu, 10 May 2018 18:03:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
In-Reply-To: <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1805101802150.27054@cbobk.fhfr.pm>
References: <20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
X-Remote-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED
	autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
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

On Wed, 9 May 2018, Daniel Vetter wrote:

> >> Then, why don't we have a pre-integration tree for fixes? That would
> >> at least simply automated testing of fixes separately from new
> >> material.
> >
> >> Perhaps this has already been discussed, and concluded and it's not
> >> worth it, then apologize for my ignorance.
> >
> > I think this is an excellent idea, copying in Stephen for his input.
> > I'm currently on holiday but unless someone convinces me it's a terrible
> > idea I'm willing to at least give it a go on a trial basis once I'm back
> > home.
> 
> Since Stephen merges all -fixes branches first, before merging all the
> -next branches, he already generates that as part of linux-next. All
> he'd need to do is push that intermediate state out to some
> linux-fixes branch for consumption by test bots.

What I do for my trees is that I actually merge the '-fixes' branch (that 
is scheduled to go to Linus in the 'current' cycle) into my for-next 
branch as well.

This has the advantage of (a) getting all the coverage linux-next does (b) 
seeing any potential merge conflicts early

Is this not feasible for other trees?

-- 
Jiri Kosina
SUSE Labs

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

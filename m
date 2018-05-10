Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2336747-1525966635-2-4510306442816356774
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525966634; b=H7qwrbWVIPwQd4QBI9u76ZWrYAhrr5nc7qiHXpXqbkK1xIU44j
    YOpRb+DKl7Kj86sZZVS/heK2qn/XidyPzPFTtyxrB1wdkJb0fBO1FgvhGSgSVa9Q
    hHXEJuOeXiyGFSrNbJvuuZjKZjUGo203oRNXc2gWuPwmEGJ5lFWocOIu7AaifL6+
    9EmDPRIeZzlJjIDKC6fsNqAKb37gnAQSo5spTMX7faNovntKXlUTwpsAFB6DvfzY
    9t9gFia6CPSek4d05XEFbEU3Fz7BQmctup9MpAga37DZ6cZBxPBf68sAWU3yGX2h
    4R1NLxOD3NLTqyT2zK6Hf+7g+kBGDLpBSu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525966634; bh=OieVn
    u3Gsz82FO3M+35RSs+Xd6E1x08exP+LfHXqTVc=; b=lT7T4g4FutG2Ebnrxddox
    eoMGGPaChAOQ3ggnDhjSNpzuJajOMYmR4X6C4yI448SDTADTrlFliL5igmRKTiRu
    r+XwaZTa/+ZUPY5f8msyTG95vOE3sGn67s8mRzQHnBnfCTiTiXYv7sQblo4VQ10E
    4BcQjGr1TlQnr40kGqZ3f+t0Uq/vyVrujlwGnMP048vtQ3WlQAtsNsc5J0REnFnf
    R57Cxbu6B+5sShT7fsvl1puaD0FH+Ur1kuMhClXS3KT/1h8CAoAH6XTIhLMgQwAY
    IhxulTlWfEnN/64yJmEWrI28U5Ic5Ea43jUlJ7HYDSUNS+3k+izQotiKSUKQvE3+
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=atomide.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=spam score=100 state=1
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=atomide.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=spam score=100 state=1
X-ME-VSCategory: spam
X-CM-Envelope: MS4wfGweb/vEbts2jj2cIsMelD5zFhgq1MxBGgxDY8ZmuIm0xGcN8jW47lVcSnBVVVJg3J4q/NkF8l5hFvkIUwbeD5N9BL7rO/jwQJl1zQuhelApcCUtXrQ+
    8aOgYtGHd5qlwytMPfL4C5/frt1dJnhvqE2CyVhKjIq0hN8ud/CSsyTW1qw9sTMhEnbnkjPGr3TuCqUO4G+pge9MeZRVjL8bh2fGO+4yuuQrLw6HSsk7nk8L
    9zu3w9uMPWp2nJDIeLHzMg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=2KMo9-giAAAA:8 a=ag1SF4gXAAAA:8
    a=5LWI5og_oGpav6HlKOoA:9 a=CjuIK1q_8ugA:10 a=UeCTMeHK7YUBiLmz_SX7:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Thu, 10 May 2018 08:36:58 -0700
From: Tony Lindgren <tony@atomide.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20180510153658.GE98604@atomide.com>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<20180508023439.GA8514@sasha-vm> <20180508034820.GE999@thunk.org>
	<20180508144958.GU98604@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180508144958.GU98604@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE
	autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
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

* Tony Lindgren <tony@atomide.com> [180508 14:52]:
> * Theodore Y. Ts'o <tytso@mit.edu> [180508 03:50]:
> > Would I pull down linux-next, and fire up a VM running gce-xfstests?
> > Sure.  But that's not a real-life use case; that's just running canned
> > test cases.  And more often than not, linux-next will be broken while
> > Linus's -rcX tree is just fine; which is why I do most of my ext4
> > testing using patches based on top of -rcX, not based on top of
> > linux-next.
> 
> Ideally we would somehow always end up with an -rc1 that people dare
> to use though for the "prosumer" testing :)

BTW, the reason why I think we all should test Linux next on regular
basis is that it's often "some other people's branches(tm)" that cause
the regressions :) Maybe because their own test cases did not show
any regressions, or because they were unable to test the patches.
Or it's because of some "clean-up" work that's completely untested
on some systems.

And that's how we end up with regressions getting merged into -rc1.

Regards,

Tony
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

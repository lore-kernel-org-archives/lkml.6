Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-121539-1525855689-2-14660340165031131664
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='ch', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525855688; b=dl7Y1GMcc5Z0+J4XGaKR6tfOHiYYrm+1uxCWw1+2q8NY4pEu6s
    haZBxzhWVZsUKkBLmrM8e327TGp+Qz3LcW1MWu6uI/Yf2ltOg2UVHYXD1C72GgrY
    DRdMrAhzNmiDPeJk5SqHyTMHXGcdosRgjwG/7qJDD3nzt4g5z+WMVJHkBhvE28Nu
    J37YBrVwh8UJKMJXsRHevTSqFAkomNnCPADZcOHipdUds7CdQvnRBNYXzMjY1/Nu
    3xdFMMeP1600WSIE5KwonrA3UM1yVaTtoJPAz5GPSYae1HiIX93BlSpbwVf/OIWp
    Oc6PYgBv19sOTjuns+1LPvn7wl7Iwv7ORY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525855688; bh=lgi7g
    hz05r39uXYxZm8p5NwbOEUJLQpCMC4qV+9uyAQ=; b=nS/86lu35AUUhlmbUmDWx
    fYm0ASbTmt9fwEsoSi9SzkAmyL6EzBbId6qeXbWKBdLcT6p87WV+TSn+45wHhbDJ
    9NANz1n+y5R7BjfryA9uvblpq1JIE4eiL1Doob8AvH92xXUf3SwxYCJoD9O6UoSe
    G1X6cfQL7OnVjz2h6GaWdcgtrj2PuQyOFi3vyhdv/cUFq0/dpVI+4sWsq88H0KNE
    zum9LnOlO9YQkgOJUct6JHgHqoZQ7Se2C2Cb0QfhAsudx6XWt5XXQ39rIlbAYeDM
    K/z7AH4u3Tl49ptRHdNfFmlS9gP6T+7zFYrX7uC0zIQ4Wm7pMkcxWiEnfTKPmEY7
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=ffwll.ch header.i=@ffwll.ch header.b=UxzWkxYL x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ffwll.ch;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=cZPu5vLd;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=ffwll.ch header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=ffwll.ch header.i=@ffwll.ch header.b=UxzWkxYL x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ffwll.ch;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=cZPu5vLd;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=ffwll.ch header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGuzoln++4XxhwLFDrkq0+ihctMIsy0jPGXN5EWiLJGLEx7iTe5kSSSrhTfrg4wZ6uNoYQtUpXlWF8eJhQoVmdHsmOzzZ8VlIR3r6DFBaVBV+9/974WZ
    TnYALCGfBRaIgyVmWULKQwZbhl/ND2Up5mS8nwH0fNNcLuMV+01MaN0A8p3tQpQSVOoW0ZXlDq6YGXbo6BbqxIJMei0MCfjJble43j0Pd3+uQYLK54WKjxrD
    QYHXLalThOj9YgztjZDTlA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=25-AhOLfAAAA:8
    a=ag1SF4gXAAAA:8 a=AbnkHBvIOuOaH6fj-b0A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=dnuY3_Gu-P7Vi9ynLKQe:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZo2bWXKo3Cp/562MKRvHBGTre6ZmfGEJDkmsy0tnhj4DyvKlMT2EkSz4vBnbJfYR7FV/+F898/9+ysshC0sIF8=
MIME-Version: 1.0
X-Originating-IP: [2a02:168:5635:0:39d2:f87e:2033:9f6]
In-Reply-To: <20180509084440.GW13402@sirena.org.uk>
References: <20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 9 May 2018 10:47:57 +0200
Message-ID: <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, DKIM_VALID_AU,
	RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
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

On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 04, 2018 at 04:21:26PM +0200, Ulf Hansson wrote:
>
>> Then, why don't we have a pre-integration tree for fixes? That would
>> at least simply automated testing of fixes separately from new
>> material.
>
>> Perhaps this has already been discussed, and concluded and it's not
>> worth it, then apologize for my ignorance.
>
> I think this is an excellent idea, copying in Stephen for his input.
> I'm currently on holiday but unless someone convinces me it's a terrible
> idea I'm willing to at least give it a go on a trial basis once I'm back
> home.

Since Stephen merges all -fixes branches first, before merging all the
-next branches, he already generates that as part of linux-next. All
he'd need to do is push that intermediate state out to some
linux-fixes branch for consumption by test bots.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

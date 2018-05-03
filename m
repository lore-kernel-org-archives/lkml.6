Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1803940-1525319584-2-508010072459647111
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525319583; b=UVC31D9n9MXYdtu3ZMxo4pDRmEjFybg3LayNRZAW2VtpGnlqo+
    N7ff0TZxRJhULVFQpywBbLYD+mjJwgYUz9HTo+owlyYThyI+CaAU4etb+/k/G1xo
    aXNuDfj6yIlXQIKQT3PYTz9e7w4k0vY5kn9GHzeug5ux12ISAx2TuNay3UqmO41V
    lVk1d/WaLvDuafymRinVZVTAIvwwa5nOfj6Uo3WSOP5TzfDmLh0eU172huDQtzYf
    onPI8a90GsXHPHeYO/l0Dfl89gqAHB8ledXd4tA4hksptJSDz2PobKHiZkvfEcpg
    iRuKT38JFshsqFXxlv6Wp3COzOnfp0wtdEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:references:from:message-id:date
    :mime-version:in-reply-to:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1525319583; bh=QiezgYI6+PLB2EFUYqq5q171jhHsZXqtQzL5MPbIIBA=; b=K
    TWkOIks/6dUcfVW1s/lDbQHXQbytAjkA72TKtN5h3W3YBCZqSYxZRTxVqgA1hKrc
    8Z3zIFIjIdvCNPmXgsr40uQWqApfBhoF8emJLHW+Qr6M+51JENHa4SLdr7QaXp7e
    kPHox/mMKcf8QfVyYmKDVDtelOunrYsMRhtFipovoyKmyfZmUIL6WYrFOz8EWsgo
    2X9zaL3v/WLn2ziLu9tQ8UXichvSECcVwbUgtIjqQkSTF8HzmENAh/gYWnb229Kt
    JMMwtuKmZnpIfbvUG90s4wJcNPV0ChCVwOh4HKKX71Xuz1E8VOw1TZhzkaN9Wdoe
    qNVYC5WvVKuurt4FC39qw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=tXW77GHO x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=law6mlVX;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=tXW77GHO x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=law6mlVX;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK2YrPFEtcK5DuVeDsvCe2FOyFBCB56GmbEEKRJZoeUyknflLEKTzdMVPYFRho56bedWeFvV4/oIv+yex+76IkgySPzI3R2hdkEXoqwVYPeBn6+Srkf+
    KDp2WUlHOil04Cb4ekiR23wO0fjOmDYA7x28MFDcy9ypyqktT6luNslRC3Tr3P2Lcujlo8aAQW7aWPRjNDJ20JatPM8eMBPGDZy3whJUxkpIGqAzxS9wYgO7
    XiKqrcjUGHI64GVOTQkLJw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=c1HvS8Pb_K8n6xRKYhgA:9
    a=l66_txCFFTmaR4xO:21 a=HuVykJWo1a-23qv-:21 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Google-Smtp-Source: AB8JxZrTL2ZXQfPtngiXqrkmdHzIWRsbMll8h5f6oAallv0wODzriBby6+PFFFII20s71ycHVtqHfw==
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Mark Brown <broonie@kernel.org>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180501163818.GD1468@sasha-vm>
	<20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
	<20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
Date: Wed, 2 May 2018 20:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503031000.GC29205@thunk.org>
Content-Language: en-US
X-Remote-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID, FREEMAIL_ENVFROM_END_DIGIT, FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE autolearn=no version=3.3.1
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/02/2018 08:10 PM, Theodore Y. Ts'o wrote:
> On Thu, May 03, 2018 at 11:05:50AM +0900, Mark Brown wrote:
>> On Wed, May 02, 2018 at 07:46:34PM +0000, Sasha Levin wrote:
>>
>>> As you said, the regression should be fixed "asap", not "immediately".
>>> It should go through some sort of review and testing the maintainers are
>>> happy with, but unfourtenately it doesn't happen now.
>>
>> Doesn't happen some of the time.  It's not like this is a universal
>> problem.
>>
>> Especially for driver specific things there's at times no realistic
>> prospect of getting useful independent review of fixes, the hardware
>> isn't always widely available and if the fix isn't a pure software thing
>> at some point you just have to trust the judgement of the vendor.
> 
> And sometimes the Demon Murphy will cause a regression fix for user A,
> to cause breakage for slightly different hardware belonging to user B.  :-(
> 

Believe me, I get my share of those. 7dac4a1726a9 ("ext4: add validity checks
for bitmap block numbers") and its fix 22be37acce25 (" ext4: fix bitmap
position validation") are pretty good examples. Yet, at the same time I had
to deal with three additional CVEs in the ext4 code. Even though the initial
fix for one of the four was buggy, I am glad that I got the other three through
stable releases.

As for -next, me and others stopped reporting bugs in it, because when we do
we tend to get flamed for the "noise". Is anyone aware (or cares) that mips
and nds32 images don't build ? Soaking clothes in an empty bathtub won't make
them wet, and bugs in code which no one builds, much less tests or uses, won't
be found.

I can only repeat - what we need is more sophisticated testing, not a more
restrictive process.

Guenter
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

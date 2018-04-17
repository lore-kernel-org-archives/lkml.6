Return-Path: <amir73il@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1716434-1523965718-2-1909147468947532238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H2 -0.001, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.161.180', Host='mail-yw0-f180.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: amir73il@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523965717; b=h0zvzb2qoX685L597BeAj1J0xyWdpN1XOngKHk+6HnfmE6xkI2
    XPve5xDjXFzFN2joq+YtPjXfdU0fNgmSut65hQyftwGQJ3/RDqLDyL60vSKugOW8
    2IUbs3JA3IWTdmgH2jRZjbWffxLEwiG+vwrmJZtjqFgQWrpMUBr8VCfdmsmTBffu
    XqM9vqln3e189MM/moz8vtfAT5RzfGL2GuzAAWIjUcM1h2bM9TZRKssSrbYRf5nm
    5cGtuwPla+oYY5+qowWh1FNU4cVi6NpORllAhNSU7LrkqqbqMW0JKUH8itNdI9Ur
    99w6weZHPL+C+ZZcYzQzT4rREXgs68CfHkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=fm2; t=
    1523965717; bh=9UK03sEtlkxaNyKdcTNcJduY9VYm01yQdIUgVdmXSbs=; b=P
    iOrqVjvm5HXx6qRxIAAj6vV1D86ZRGE5tShEpNZSTpzczn7ha6iY3K4+w47uDBMq
    xgogXqZdyJ27ZzwZWcvK8KOMSMsLjjVhWdSRw6psMawq0CGUY6nbUBBmIS2wyB79
    BcBzIxo0gxI74I8kxf1YyVDizp7a/0GNHByCe4dKN+NROzYCQVaG2eQtGHFzYgU1
    mYsE58YoxUOb6XOUvZAevMagwrNrSvXLLm4jzjBTPJK1O4EUa/HKUIhHpSCTN8YX
    bRWoSGs26SA/s26CNEdf/jeSTpYRe/7xIelLt/dGDfhZKqxYuzWZllINMA9rhWCt
    PzjlJ/SfBXI/7EftU0m9w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ALl1VNcJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.161.180 (mail-yw0-f180.google.com);
    spf=pass smtp.mailfrom=amir73il@gmail.com smtp.helo=mail-yw0-f180.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EtAsgWiS;
    x-ptr=pass x-ptr-helo=mail-yw0-f180.google.com x-ptr-lookup=mail-yw0-f180.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ALl1VNcJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.161.180 (mail-yw0-f180.google.com);
    spf=pass smtp.mailfrom=amir73il@gmail.com smtp.helo=mail-yw0-f180.google.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EtAsgWiS;
    x-ptr=pass x-ptr-helo=mail-yw0-f180.google.com x-ptr-lookup=mail-yw0-f180.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPSkaothTrW+x1B/YLsHg+DXSvQ0ACA17n8qzj2c+CWWTan6m5m/mKYt1OIKSFJ1a7yTcNcTA4gwafHxFc779xbK12x6s91YCPIz6jW6AqbCQICfyYBN
    5LUoqkb9fub4DkLUn9QhSVcRDPbtP0VzPV5bgl0qtnR0INc8sVT4iDyKi9YMmfHJQtgi/mZp/vdTa2d9vdkLmGlVli+FeLmEvtU=
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=aunOHHLbbW4qosc10NFHcQ==:117
    a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10 a=r3nPLSDzUwAA:10 a=Kd1tUaAdevIA:10
    a=2C6YHBdLAAAA:8 a=VQ3lpI-JKVmXp3uUaCYA:9 a=QEXdDO2ut3YA:10
    a=yxGMNg53M24zlVSZdvMH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Google-Smtp-Source: AIpwx486i7FMfD515BN4Olu6H17vL4YmPpIiKL6cQa9GR/oAV22GBKeDaZ03eVwwUjBI3r9X2KsEg+mmTkRXSszSQlM=
MIME-Version: 1.0
In-Reply-To: <20180417103344.GB8445@kroah.com>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz> <KL1P15301MB0006B378757EC8F6B4D87BBBBFB00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180417103344.GB8445@kroah.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Apr 2018 14:48:35 +0300
Message-ID: <CAOQ4uxix615i5pVFURtfAH3OmgiYuy37WD7hM8tA=69OCv9B1A@mail.gmail.com>
Subject: Re: kernel panics with 4.14.X versions
To: Greg KH <greg@kroah.com>
Cc: Dexuan Cui <decui@microsoft.com>, Jan Kara <jack@suse.cz>,
	Guillaume Morin <guillaume@morinfr.org>, Haiyang Zhang <haiyangz@microsoft.com>,
	Pavlos Parissis <pavlos.parissis@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "jack@suse.com" <jack@suse.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mszeredi@redhat.com" <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 1:33 PM, Greg KH <greg@kroah.com> wrote:
> On Mon, Apr 16, 2018 at 09:10:35PM +0000, Dexuan Cui wrote:
>> > From: Jan Kara <jack@suse.cz>
>> > Sent: Monday, April 16, 2018 07:41
>> > ...
>> > How easily can you hit this? Are you able to run debug kernels / inspect
>> > crash dumps when the issue occurs? Also testing with the latest mainline
>> > kernel (4.16) would be welcome whether this isn't just an issue with the
>> > backport of fsnotify fixes from Miklos.
>>
>> It's not easy for us to reproduce the fsnotify() lockup issue, and actually
>> we still don't have an easy & reliable way to reproduce it.
>>
>> According to our tests, v4.16 doesn't have the issue.
>> And v4.15 doesn't have the issue either, if I recall correctly.
>> I only know the issue happens to v4.14.x and 4.13.x kernels
>
> Any chance to run 'git bisect' between 4.14 and 4.15 to find the fix?
>

Looking at the changes between 4.14 and 4.15, that are not in 4.14.32,
the only viable suspects are:
9cf90cef362d fsnotify: Protect bail out path of fsnotify_add_mark_locked()
properly
3427ce715541 fsnotify: clean up fsnotify()

Both don't claim to fix a known issue.
Both look like they could be applied cleanly to 4.14.y.

Thanks,
Amir.

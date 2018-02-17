Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2747093-1518869964-2-16168610649924027303
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518869964; b=oXdy7Y3gbY/1Ffzz1rkHHpSTrQTH3DrEbBZJJ+VWTCueLha
    /btM97HE4KJLvlPlxc++eadj8q075NYYXqph1rrykZ/Cr3kKf18U3XMI9h39GqJP
    2gAlyFic3gbQB1TjWbzx2HKbN9ZX9Ilnh77i0lfnGFyRQhjKQnTGHSdfXlccknG0
    ccPXNlzYGlqSH/AkWOVyO8srf+WDjTx7cXFE0j/gpEbFCrUhZUOzWOUJZLqC7y6v
    YHguK1sY2oi6IxhaBDkiaGWZV2KL63Z024SCxY2Hm5YQHpMtbYtwXb7cMvenLbvW
    L0mJY3kbBuljtVI3sRm1b4k0Ts5Pt0jRdvkaM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518869964; bh=j
    9h9nHdD1wFJHO5K3nZBEoE3FX0eXUthU46NbmjOxos=; b=dMUQC5mjxE1gHDanf
    O5YEb0EU+pzjTK/d2947b4ffEBQF2ylDuuZ0v/2xjQNx26hVPUg45j3jJwjrlIVq
    DANFm1jxDKD0bchSWBntzEvqhvVNENkvJImY1QPXVieSvw7Tycb865aHYCAW4nmY
    gOzFTFHtbTXm7JS2KZRnla2yyUL9Mpq+Of96thrJV5BRKdc3c84ZFoXlTFhhKszH
    TBGTTdvvyO3lhNFmxPcz8kMUtwtPgQt8+KAvUzQ2w9C6jy1UCaBvxleuxlskxFvq
    gsKGSJprwoDtOd3xligBpNHY6qE3mQUNlNoSBU+FHlW8UBqvom2TWWH9qr2GI4N2
    D+Ekw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A534E217C1
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Feb 2018 12:19:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments
 and add suitable suffix
Message-ID: <20180217121912.6b7cb5ae@archlinux>
In-Reply-To: <20180212194604.GB15335@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
 <20180212125312.cjo76spuu6agjawc@mwanda>
 <20180212143522.GA12142@himanshu-Vostro-3559>
 <20180212145731.kws25sjinzqq6ax6@mwanda>
 <20180212194604.GB15335@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org, 21cnbao@gmail.com,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Feb 2018 01:16:05 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Mon, Feb 12, 2018 at 05:57:31PM +0300, Dan Carpenter wrote:
> > On Mon, Feb 12, 2018 at 08:05:22PM +0530, Himanshu Jha wrote:  
> > > But these should be done when we have *more* instances.
> > > 
> > > For eg: 
> > > I added a tab space in function static int adis16201_read_raw() argument
> > > to match open parentheses in this patch. But I also added tabs while
> > > removing and adding suitable suffix to the macros. So, should it also be
> > > done in a separate patch ?  
> > 
> > If you're changing a line of code and you fix a white space issue on
> > that same line, then that's fine.  If it's just in the same function,
> > then do it in a separate patch.  In other words, adding tabs when you're
> > moving around macros is fine, but adding it to the arguments is
> > unrelated.  
> 
> I will try and divide my patches next time :)
> 
> > This patch was honestly pretty tricky to review.  
> 
> I am sorry for that. Might be easy for IIO reviewers ;)
> 
> > Jonathan assumes reviewers have the datasheet in front of them and I
> > assume that that they don't.  He's probably right...  But especially
> > comments like this:
> > 
> > 		*val2 = 220000; /* 1.22 mV */  
> 
> They are pretty obvious as you can see from the return statements
> just below that which is :
> 
> 		return IIO_VAL_INT_PLUS_MICRO;
> 
> These comments are obvious because we know 'val1' will be responsible
> for Integer part(1.0) and 'val2' for the Micro part(220000 * 10^-6 = 0.22).
> Isn't it ?
> 
> Although I am new to IIO please correct if I'm wrong.
> 
The oddity here is that the base units (here mV) are inconsistent due
to some ancient attempts to align with other subsystems.

Dan is perhaps correct in that the comment might be helpful for that reason.
If so I would prefer to see it made clear what is going on.

/* Voltage base units are mV hence 1.22 mV */
Also should definitely have it's own line rather than being associated
with just the val2 line like it currently is.

Jonathan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

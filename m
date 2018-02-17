Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2747092-1518869776-2-13728483444815172824
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518869776; b=FY+Tu4mrRzRkZ1yqdJvzboe4WtNyTuPJC5rpikBXrm8RHlq
    sZrg+dV/UkPE6aKeHjuuUIsQ6J4hh2iBYYe2VCFAzpK52XrhPeHUM/4J02QjihKk
    NXxE7BjruJCc3qTgvX/tGj6OFhoxjYuJ8d1QMQOj1xtVJfwGtoQKpe+B7E/3nF8S
    mrskfmpdfyMB0uxx9dlvOTDNu5phtjeNDt+N799eTkDJ5aGZqyy0IjdBRbHnyqa8
    CfhveSCTTnRpEdVxYWXew12ZFFTMZuSNiiUCSH8tzYjXxMcmJDBUMcqLisjI18nL
    PfqsjrUKGtp2/V2ltGY0+EA735hOw7gLZU7rxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518869776; bh=9
    UNaN0g83K83OdFuil1LZu2eJRIQAbCKVifmfqBJhuk=; b=ZWp7w2oxh3HWLha6k
    3YLHQ8/uijsY+qm4vxV2IhRSz3F4StsKny0EUsHRsvT3r6+6LJlzQJ0HWwwlKdyj
    U9fEfhbBvquqpHzRo29LAEPev7hgebck+nGq2x1GikR6B5uvsB3HV3x+TZYJgXUA
    2xNXVgRd84b8jrXsv4a8QlC4Eb+V4hhQ7jK+7lsxdvfBD1xzzu4VFDJRVjlirFs5
    MQ/lsiod/MuzVozxoSLvG6GUOsh/FbbuOWG4xmKlM+6f7aT3e+lBDcFQMBnXLdHm
    L/7qJscx2mz80iiZSg9S+1UctE3xJajS/q0y2lA2p32mbZ/rGDXH/1AEb+SKiOsX
    J4GJQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FCD217C1
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Feb 2018 12:16:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments
 and add suitable suffix
Message-ID: <20180217121603.1551e27b@archlinux>
In-Reply-To: <20180212145731.kws25sjinzqq6ax6@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
 <20180212125312.cjo76spuu6agjawc@mwanda>
 <20180212143522.GA12142@himanshu-Vostro-3559>
 <20180212145731.kws25sjinzqq6ax6@mwanda>
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
 linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 12 Feb 2018 17:57:31 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Feb 12, 2018 at 08:05:22PM +0530, Himanshu Jha wrote:
> > But these should be done when we have *more* instances.
> > 
> > For eg: 
> > I added a tab space in function static int adis16201_read_raw() argument
> > to match open parentheses in this patch. But I also added tabs while
> > removing and adding suitable suffix to the macros. So, should it also be
> > done in a separate patch ?  
> 
> If you're changing a line of code and you fix a white space issue on
> that same line, then that's fine.  If it's just in the same function,
> then do it in a separate patch.  In other words, adding tabs when you're
> moving around macros is fine, but adding it to the arguments is
> unrelated.
> 
> This patch was honestly pretty tricky to review.
> 
> Jonathan assumes reviewers have the datasheet in front of them and I
> assume that that they don't.  He's probably right...  But especially
> comments like this:

Actually I don't.  I like the code to be very clear without the datasheet.

That is one of the reasons I always advocate making it very clear what
is a register and what is a field. The _REG postfix is useful to my mind
for that reason.

What I really don't like is needing comments to tell you what a register
is for when the name of the define should make it clear.  Obviously
there are sometimes places you can't do this because the meaning cannot
be explained in a short enough name but they are fairly rare.

I agree it is a trade off on whether the naming is sufficiently clear
or not and your example of the power supply one is a classic.
That register has a stupid name on the datasheet given how easy
it would have been to make it clear in the name choice that it was
measuring the power supply.

The naming things _OUT on this datasheet is particularly nasty as
it adds nothing other than confusion.  However, the question arises
on whether it makes sense to get rid of that in the driver and
make it harder to read with the datasheet.


> 
> 		*val2 = 220000; /* 1.22 mV */
> 
> They seem really helpful to me.
This isn't about the data sheet, it is about knowledge of IIO.

That one is perhaps debatable as the base units for voltage are
less than ideal (I really wish I had been a stickler for SI units
throughout from the first - this came about through trying to maintain
compatibility with hwmon which with hind sight was a bad idea).

> 
> regards,
> dan carpenter
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3343216-1520694331-2-2652664512315694588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520694330; b=MkaU5yNjQojf4QNAINlVoF4y09TZZWL2g3X52fn1KliqlYJ
    kI403cn3/9ADrhU26vaUurW/ZZp9j0B5BhjByElrauv9G0hKqAVK7H1g9r4Vi238
    /GVHMjICQVDNk97RfjrF6HMa3vhD++09kYmAiJYtz80+jGYLcZzSQMg+Pa0YTLck
    9E0DHMYwGlYvG2IvHZ4f3fkUU+hybCec+mcEm/q+IimRHRr+10pEc1V1/0eoBNiJ
    SjT6pd7NiJTAxKQJ5I4srsh4uIWuej0wYTbL86OwIXl4qPhnnNdv823nQSJG+U6r
    Fj8F0WQPdkU29r2qXtrQ51Xz1ue0IHy9OQgz1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520694330; bh=y
    TTpm6EFKmdRrZn5+FkRsAw167PK+P1TktbXonh0Gco=; b=Z/oIOBCtFIWWyQHmP
    RDQJzzTR3wXoo9QOhF0GR/N8USyGyGNtljly5pnMS9kUVkbodZTGUD/8lWJjC38h
    q04/mII4GrCsse4LSHqm/vT8TGOwt4xFDd29AJNdNmw9tlJ1PxrMlY9Hh0XWhqL8
    KS8t8Q5U3cN8A0qLvdH4mo2dXOa5B3+N663LyUhv0fE1XZ7KVlthoQYFTM8qyGrc
    lo/SIYIHsobe6a7+jHEIpbt4WBuv9S4Cq8NzAaX8vVcxxc5jJhiyBwUZcVKRzdz1
    kTtwVxAvoSGelUah02KMRlj7d2sqzntB4jphWrkcXayt1l5gwe0XfA7qpmHk9VRX
    S24+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D42D208FE
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 15:05:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 10/11] Staging: iio: accel: Add comments about units in
 data read function
Message-ID: <20180310150517.08a57a17@archlinux>
In-Reply-To: <20180308072819.GA24090@himanshu-Vostro-3559>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-11-git-send-email-himanshujha199640@gmail.com>
 <20180307205030.11fff428@archlinux>
 <20180308072819.GA24090@himanshu-Vostro-3559>
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
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 8 Mar 2018 12:58:19 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Wed, Mar 07, 2018 at 08:50:30PM +0000, Jonathan Cameron wrote:
> > On Mon,  5 Mar 2018 13:19:29 +0530
> > Himanshu Jha <himanshujha199640@gmail.com> wrote:
> >   
> > > Clarify the conversion and formation of resultant data in the
> > > adis16201_read_raw() with sufficient comments.
> > > 
> > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>  
> > This is fine but it needs to be in the original comment changing patch
> > rather than removing the comments first then a few patches later putting
> > back a different version.
> > 
> > So good change but in the wrong place in the series.  Learning to reorder
> > a series and merge down multiple patches into one is very useful when
> > working with git.  
> 
> I will send v2 with all the updates!
> 
> What about sign_extend32 & reverse christmas ordering patch ? Will you
> pick that up or shall I send them again ?
Please repost anything not yet applied in V2 of the series.

Makes it much easier for me to avoid missing patches!

Thanks,

Jonathan

> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

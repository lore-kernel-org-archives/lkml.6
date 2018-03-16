Return-Path: <pratik.jain0509@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-2667790-1521196178-2-3537397670412214063
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.68', Host='mail-pg0-f68.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: pratik.jain0509@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521196178; b=jTl4UMcapTJMjweZBfql8WDzCJKGtcU30YsyddDnmADC+v4
    hJZ5Q0i06EophAHB+InvH3taJeXXl8QotFDzMMWLBX5rcosuB+ATEiTi/FAumt5n
    r2a7qi5jxdCilWWLB/RAWDIPowjOrInDwZTpYdaOqCKcx7FZ0WsXsEX/i9GINnup
    kmWfYRHbmIMfDEAq2Bn13ruosfaH4Y7/QmUVBUyUEXD2w2mt7knK8dsWgCwmzn6I
    DqOcpBBJYYkSdgJZABWVIVTU1HFWeSj58bEzYBhXZBoKFjHNcXHRbRGT+s4Cf1ZO
    t7Qvd73tStuGKvaKSZ833MYEjkYOallg7SNFVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521196178; bh=nnaTBR/lhaBEaMm5ULfZhx3+QfZpcgFD8GSJa4Am+io=; b=h
    knAnDKnzieDpK0JBZFKD+sWxU6wJlvpG63usLHdoASSI0iToYZNH/jnrPztI+Xol
    9d1nIt1YGTJKY9fWc5LaNBT2xaR3MuAo6aGrkFgMaEuv07p8Hx/4dMAwHcN5dnL2
    Sxj9uSl3iAkpxbB8fpk9Bmx7NJrAuJaaMkgGFUZrSeet8310LugKpTk41Y1yAo+g
    NEMFvOwKzkSOGtgPwrXbhk8bZ0IIL1ZKzfTaTyGZ/3zKvya55i0ncmvo3UykKWG/
    Fx44Trs99w0pGkYrEmA9My/LFSj9T7NIlY3j86OeOsG7xoIpnCkEzvPddfF4HbjM
    B0HHqCfhRyHNpUdyYXBIw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lbXYFYr+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.68 (mail-pg0-f68.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-pg0-f68.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t7rsS6a7;
    x-ptr=pass x-ptr-helo=mail-pg0-f68.google.com x-ptr-lookup=mail-pg0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lbXYFYr+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.68 (mail-pg0-f68.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-pg0-f68.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t7rsS6a7;
    x-ptr=pass x-ptr-helo=mail-pg0-f68.google.com x-ptr-lookup=mail-pg0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELuskEyY8D43tsaa2Ybch0+F5/x+rIf1uSiAPEIWMzz0QGKA62L+g3oVwQ9HAkb16oT10rzt2w==
Date: Fri, 16 Mar 2018 15:59:31 +0530
From: Pratik Jain <pratik.jain0509@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
	devel@driverdev.osuosl.org
Subject: Re: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line
 derefernce issue
Message-ID: <20180316102931.GA28344@archlinux>
References: <CABbwmYcnDNcA70_-BhLkBcuK-77tk3BWKcvzQts6eWqu5_mMKA@mail.gmail.com>
 <20180315185943.18902-1-pratik.jain0509@gmail.com>
 <2dd4e733-b74a-c296-a554-3520a85e8ce2@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dd4e733-b74a-c296-a554-3520a85e8ce2@mev.co.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Yes that can be done. But isn't 80 column limit more of a
historical convention?

On Fri, Mar 16, 2018 at 10:17:28AM +0000, Ian Abbott wrote:
> On 15/03/2018 18:59, Pratik Jain wrote:
> > Fixed coding style issue.
> > 
> > Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
> > ---
> >   drivers/staging/comedi/drivers/ni_atmio.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/comedi/drivers/ni_atmio.c b/drivers/staging/comedi/drivers/ni_atmio.c
> > index b9e9ab548c4b..4e27a2959b64 100644
> > --- a/drivers/staging/comedi/drivers/ni_atmio.c
> > +++ b/drivers/staging/comedi/drivers/ni_atmio.c
> > @@ -226,8 +226,8 @@ static int ni_isapnp_find_board(struct pnp_dev **dev)
> >   	for (i = 0; i < ARRAY_SIZE(ni_boards); i++) {
> >   		isapnp_dev = pnp_find_dev(NULL,
> >   					  ISAPNP_VENDOR('N', 'I', 'C'),
> > -					  ISAPNP_FUNCTION(ni_boards[i].
> > -							  isapnp_id), NULL);
> > +					  ISAPNP_FUNCTION(ni_boards[i].isapnp_id),
> > +					  NULL);
> >   		if (!isapnp_dev || !isapnp_dev->card)
> >   			continue;
> > 
> 
> I suggest splitting the expression just after the '=' to avoid going over 80
> columns.
> 
> -- 
> -=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
> -=(                          Web: http://www.mev.co.uk/  )=-

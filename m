Return-Path: <pratik.jain0509@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-1058499-1521143360-2-5553180547587483124
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.192.178', Host='mail-pf0-f178.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: pratik.jain0509@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521143360; b=ZvFyJf6Aifk7UfKSTHZqODEjRbv+SP3FYTiHHk5jSgpEMWu
    ygvEKRcn2fKoNI2Kcmw2esAmQr7bsOHhUeseG0LCSlbByFYJ2wyYPEvVxO3N+5CI
    2NZZByH/5kCCypR3V1Kxio7TE+7WU7niehB01O3ml/xMOMX5JDOjKbfsWxjB/wrb
    rO3PIpF5oWOHMYDxMFFmgFY1hDuT+uC5CtSXV4veFZS6UkH3IxnuuOSro1vj3/VJ
    Ea4IrlFitYpPztXSctXkFZEyKkQacEx4MDNF6VygVBRAvYy/J0FpkPfArszqHAU0
    MIwATBsIyKRQVu4VAGR/UbS9CGrnfcLWuVma5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521143360; bh=BY1zkDrv8H0tuftltFnPduh8IWcvaIni49WEfnXjZTU=; b=Z
    2uqqX8S+5PQwhMUBVqsXao0bgoXM4jujeNyo4WzVtCsmyI83C8rF2rVM2KRkvf4Q
    QPYWLyNQfs2ghbXA8R48fGvcFoYirM2ZCvCZIpUiU7nc8C8Lr86z5RwWjU2fjg7R
    nHRQ1bhvKxlXKUnDSZD2GbCRT/GAi8ltw9pCSt8likCAKeOeChMRuIXUuOay0jCo
    x1a+diVzxyp+9k09k+B29ZGp1ypzcbAb4+gnuEN27YRhcKqBV23amLRdMaCFdjWc
    AGVQuUHFZEariuv6riOMTT/QjRDTkJTKVE0IRq9yciX4FyC824tz8r8uWV0eVvuZ
    iEEPLJ1jllYOfZvO7GVBg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W3zSOkse x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.192.178 (mail-pf0-f178.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-pf0-f178.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bCr7LCHO;
    x-ptr=pass x-ptr-helo=mail-pf0-f178.google.com x-ptr-lookup=mail-pf0-f178.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=W3zSOkse x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.192.178 (mail-pf0-f178.google.com);
    spf=pass smtp.mailfrom=pratik.jain0509@gmail.com smtp.helo=mail-pf0-f178.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bCr7LCHO;
    x-ptr=pass x-ptr-helo=mail-pf0-f178.google.com x-ptr-lookup=mail-pf0-f178.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELv0UH424by+uRbwn7gFnwWC7+zyF8TBvkuWvUEJc5uhwT9CsVnY+pLsmidWpDk+6AKCSPMq9Q==
Date: Fri, 16 Mar 2018 01:19:12 +0530
From: Pratik Jain <pratik.jain0509@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
	abbotti@mev.co.uk
Subject: Re: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line
 derefernce issue
Message-ID: <20180315194912.GA20259@archlinux>
References: <20180315173040.11468-1-pratik.jain0509@gmail.com>
 <20180315173934.GA30586@kroah.com>
 <CABbwmYcnDNcA70_-BhLkBcuK-77tk3BWKcvzQts6eWqu5_mMKA@mail.gmail.com>
 <20180315193246.GA1565@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315193246.GA1565@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Resending the email because it was sent only to Greg.

Context:
In my previous patch, I had removed an extra newline
at the end of the code.

My Reply:
It was unintentional, but does it violate any coding or
other standard?

Return-Path: <jhovold@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-826942-1524472218-2-5647338119330790148
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H2 -0.001, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.215.53', Host='mail-lf0-f53.google.com', Country='US',
  FromHeader='org', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: jhovold@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524472218; b=cSX2NerSIhCJM3q3UDe5jnpcEbj/IbOIDXARw+2E8zBlmyJJ0e
    hJRpkMPNAaxrpVTnEzovlVEcWDt8vAQkxjWBV6fcYxIFN5uw9c90Q1oBA6E71k4t
    cH6WIiijlho1NMMgwdAglsPiKbAll+vzaX+tCwsIB5NvlN/n6GuJ965nSgoQPX3d
    S1msK+bi++dl2L7R0W/18UQHXXRp1/csKd1NNftKKvsMh7YT+gos4KeIiUanyNMP
    SIuLmmD4pLN4q1jMcSjo6Z3xp9LVT/xPFIL2oGu6Tuvq3MCoz6WMiVzEHIL7mdEf
    gnNrtwsLmFT5M56gzgS/+gwfIEscoQecH2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1524472218; bh=d3Ym+PGiWzipOXpq8L0uUcxqEJAOmgBd/FR325WLm/4=; b=n
    hSainilEiqdF7MRznq79WN6PT65w++wzf0cEJxOrdynebojMkl3BNGMZNL3vNZai
    KR4FKUYWJwoE2g3uj6zeJ+ZMpx3c+29dgOiq1wykjsnUPKNwKDCFZqy37BQ1GAfA
    zz/NpwNQrfOJwXmXE5st4yBYW9slYTkp8aW8atP8wqpPT/MdwhZyvni/at7obzdB
    QmuaVZxOnWREpIqq6e0ejabEieFQCw77YBLYDSR/Z6n2z+K+dDwNjQCHzM+S/peO
    be7az121VFAOdYVaIFSMR/wBafZZoWilnG84+C45RV0xYbZjG/zGDqXOVZwzOBYX
    QeML31G7+HJtWt8xohaIA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NTk5tLfi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.85.215.53 (mail-lf0-f53.google.com);
    spf=pass smtp.mailfrom=jhovold@gmail.com smtp.helo=mail-lf0-f53.google.com;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pHqHL8k5;
    x-ptr=pass x-ptr-helo=mail-lf0-f53.google.com x-ptr-lookup=mail-lf0-f53.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NTk5tLfi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.85.215.53 (mail-lf0-f53.google.com);
    spf=pass smtp.mailfrom=jhovold@gmail.com smtp.helo=mail-lf0-f53.google.com;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pHqHL8k5;
    x-ptr=pass x-ptr-helo=mail-lf0-f53.google.com x-ptr-lookup=mail-lf0-f53.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFHhbhr/fZlnSowfmHZ+fRm60VqLHpqSUVCmeWcf/S1k6u1rADcPNmree45yvm180MH6PTFQjVZ/zBHAAJD3bhICwbWNy0XF1UBkdH12Y+RNaUJx3ebk
    kRbsPbws70DlpfsZHVXYPzIY5mPa1ickL4EMrQk8LKSzPJi0WaChgMYdMrKnfMJ87x3LQci4F9HaQg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=0NY8VBO4CwiEcDG2u+ccog==:117
    a=7pTxdCEnTQT8skA7NN1Jkg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=heaVe8kJGxQrPOF7MpcA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Google-Smtp-Source: AIpwx4+cj84yqE0kGYEjxzOX6dTmhwAWe1d7WAQCDnWc3EByA45TZ7d+t4PiXaz0upf7CNyI6XVUPQ==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 23 Apr 2018 10:30:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Johan Hovold <johan@kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <20180423083011.GP9198@localhost>
References: <20180423130444.0672fb80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423130444.0672fb80@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 01:04:44PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/core/hcd.c
> 
> between commit:
> 
>   63cb03f5c11e ("usb: core: split usb_phy_roothub_{init,alloc}")
> 
> from the usb.current tree and commit:
> 
>   bc40f5341741 ("USB: core: hcd: drop support for legacy phys")
> 
> from the usb tree.
> 
> I fixed it up (see below - though I am not sure what happens to the
> phy_roothub allocation when usb_phy_roothub_init fails) and can carry
> the fix as necessary.

The resolution looks correct to me. The allocations done by
usb_phy_roothub_alloc() are device managed and would be freed on probe
failures (or unbind) so not explicit dealloc is needed. It might be a
good idea to indicate that in the function name however (i.e. to add a
devm_ prefix).

Johan

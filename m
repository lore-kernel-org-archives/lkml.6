Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2430669-1527189484-2-2814169459007482130
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527189484; b=XTYpt+HP5JaPM4CsXHwpnnSg5s1kuOUpjSqU4cyUWcrHNuTAYY
    Xcyqxklg1JT1epFq7id6aZixOS+QkXzzNRHDOu1m8FHn5STvdqDj4VyEAAqIHP+3
    m3sW1rr6v6XBor/g+d2fJrtHpqIFV4zdVKC7ZTfvaKkWTn6L52En1OL0g31xoidk
    dqPLQ7mlCC88sPZHlLEHlprumTVa414x4RFBd3SSACdpcelZGWQ5qjVIMWk3AG8S
    D3pLfvISXnGTeTEYUcPGrnPtKrENkxEWftGgGUtdowfaK/RoY0VNPYvI5SWwsmlr
    tnDRFnXV/VyFfCWp2P2NxpREycFy41LfBrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527189484; bh=aaerJ982p2l5KIENcegWIuxPkiS+D4jKim4KsfabQW
    c=; b=M8+0txdA5WXm5fX2ocYpmr68YPbdP+UQVkfxrvKxsyv5ADws229EWhW1ky
    7q9wczSGG75rxT8dl2/P1tx5Kjl2/TlRvEMadh1bNWT2KQmrmgP+/nnA1qVV5PlL
    UrjhaFMlf99C+eVbCvUClGU5PTEgd3Pej0cPCtRMGGPKQsG1Oa1kvw3w9gkZu0Us
    h6UtGrhRE+Uc50r787AwITRsbjCKYfEtuVfeqsdLeo3IfG2bWrj3V7my/P+MHMd0
    VTCELcxmi3Hq8qRfk/Ed9kYit4H6WU5DiW0D08N8Se72jhGlHw96cinijb5NZN1B
    zt6cJAD5u8RMFik3WFZA7JBMqP8g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linux-foundation.org header.i=@linux-foundation.org
    header.b=OYqVFSkv x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=CQOPyb3+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linux-foundation.org header.i=@linux-foundation.org
      header.b=OYqVFSkv x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=CQOPyb3+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNnF5Z2QHxDiyJWqj2cgxpSe7rnwVBeSgvBonMnMqiz7Mm3Fyn13jrg0dMW1LcwFY1NJqByDWJKMFprkmR2SKvne5dWMNFxgRmSWr0ZBj/3Ez1H/BuNF
    XngSEWtcoPVx0FqMHZ+U7AmkZTTXGOdXs947Kd6EvLuUbbzfVUynGr9Fq2CY7Gea8QstPvgwGjF9f8es83wwEwfB7aBPrk2B/IWeHAkEiUViWEtWZS/7MwqQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=R4ayLD03AAAA:8 a=VwQbUJbxAAAA:8 a=PxCpapF2sx8BWePPZXsA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=qJlm0-shE6CLU_iKUWNr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968418AbeEXTSB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 15:18:01 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:51998 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967476AbeEXTSA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 May 2018 15:18:00 -0400
X-Google-Smtp-Source: AB8JxZpEFYIx7ATWckeyLbLo2RL3n8goH7/EaK0bRYJA1TFmcih6++qceMIXpDksUc7614fO4oI5aF+Ab+ZFJwLY9nk=
MIME-Version: 1.0
References: <20180523172500.anfvmjtumww65ief@linux-n805> <CA+55aFwAtfiMa22-OFGf1dNR8CNzSKjjLLj5UL-HqgapV7Tf1A@mail.gmail.com>
 <20180524170700.wblnybinjzx5rwky@linux-n805> <CA+55aFwhkOnHngHpQ3wif5iy7PtOAVdjTcwce=kgBq0TCgmfJA@mail.gmail.com>
 <20180524185155.3bx4ujgz5f5g3epi@linux-n805>
In-Reply-To: <20180524185155.3bx4ujgz5f5g3epi@linux-n805>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 May 2018 12:17:48 -0700
Message-ID: <CA+55aFzfEsC9op0UzYte7OaWnvv9Czqr-0owFo0FGDqPcfGiKQ@mail.gmail.com>
Subject: Re: semantics of rhashtable and sysvipc
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        guillaume.knispel@supersonicimagine.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 12:08 PM Davidlohr Bueso <dave@stgolabs.net> wrote:


> However, after how about the resize being based on HASH_MIN_SIZE instead
of
> HASH_DEFAULT_SIZE?

I think that sounds reasonable. We wouldn't expect this to ever happen in
practice, and as you say, if it *does* happen, the size of the hash array
is the last of our problems.

> Considering that some users set p.min_size to be rather large-ish (up to
1024
> buckets afaict), we'd need the following:

>          size = min(ht->p.min_size, HASH_MIN_SIZE);

Bah, let's just go for simplicity, and just make it HASH_MIN_SIZE
unconditionally, and just have a single fallback: if the first "normal"
allocation fails, do one single unconditional allocation with HASH_MIN_SIZE
and GFP_NOFAIL.

I think that should work fine.

                Linus

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4028164-1523370872-2-2261604851836748056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523370872; b=KE4bKxQ6hFG4U/NIt8Ja/LgyHUGbw56dN1Hf8SH9bkuuxHdvj5
    +3oi2PsWGj1ezwUmz+07DG3h+G+0mplpu9nmi9/17GnRZdYOu6lIkQaBaS/HSqlq
    WzsZOern8eSOqoGhnMSbfq6VoVH3Gn6cyeVtolU014ZQ4OciFtnw1E+ecjyGLBhl
    xw39TowPWlcS5wsdxrgpn2OyKIBoEpWsYv17eqZ02Q5M74XUcKREUEzHvB7IqH+F
    LCbtewnkgzu3p+FM1XJEflCl7qGfuno173omtHgWwjBGtZVDPvLFd3gz0K48AFU4
    II20HD1f9KaFv+8t5HkVh+jWDchN7vwhap/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523370872; bh=9ymNhfC54K43E1+feDzWeAsPnoWxqiqeHcKBHrR
    akFU=; b=qtiOjSgtumDlgdgRSKIWRXCMdePQScYOrjntWLz7DVqA3Xrv0B1nUhM
    fIBVUB4aAa2ynKSV31E9W8Q6LGi98u1OcBavCP1ef++XXvtCGHPsEHOkpLfAIDKB
    Gk1y0c4NNiY/aSUI5KT5HRct6uNWUY1H1inKsy8l3ZPlxpS/vrbEeFPgQ6q6vocu
    8rYCwR6vg4MQsecqiDOLsDG5ZSz+vRcWmj//YukLm5O0+m0/lhFhoYFHWe0CnOI2
    knvzESupII4ADBV2djB1dRLX6lVNoPxAffuv8rGOFmYgu9XpIPLfGYS5+9E7Eesn
    rWPfLkbHw9VR/q83oHeBChbMfQcM3zg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOAlPtQPGZ06sM7Ck7A1uuZqdwtNzW8Yp7rQAcRu5viHgnQiSkc6JP07WN/o2cyg9O+TLaNXbv50ZLKyJFJCR7/yVSW9rMpAZ/JdJdvq7hvozWHKdzNo
    FnOIFbQmw9496BOuBwaceQJXvRh5QKphQwp0eGFu1s1lPYZvykaht2jNO9Sww9qI7XGai+keekGgS+ZD9EbJHr7lOA0TEr/pBSH+ewGN4bgT+7lixvi0+Xr1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=Kd1tUaAdevIA:10 a=TnQvLH7FQ8jPiqQ9jnsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeDJOe3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 10:34:29 -0400
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:33528 "EHLO
        resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753258AbeDJOe3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 10:34:29 -0400
Date: Tue, 10 Apr 2018 09:26:19 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a
 constructor
In-Reply-To: <alpine.DEB.2.20.1804100920110.27333@nuc-kabylake>
Message-ID: <alpine.DEB.2.20.1804100925520.27641@nuc-kabylake>
References: <20180410125351.15837-1-willy@infradead.org> <alpine.DEB.2.20.1804100920110.27333@nuc-kabylake>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfEoSLJu4PEigK+VC8JBxRPvaQKIrS4szM3RGwOKicFCKKWnBZwmdSF65G4d6YKrdlBZ6k23iycY4eJSkftjo3FZRiXDaGO8C6JXcnbHQFcJt9j0ABPaI
 7J2LF3TMYAzBAexY+NJtTJORESpH4KChhfGZuyqioEVpFE9eqZQX40njvAkviMkskFG/r2a3UYIGvWgJJXuI9fFZru/GLtRzR354FZY45VpKTwtUPLWlVcaA
 PzCLzG0qDLdasbC1Pec/Xbar/7lCKqYVbK6CwPBIwVFj9RRWkjoTNIlXNPZrle9PW1JR8i4Q2u+VtDEFpyqx5geBOBbgzHgjnDw717Qo1COHryFUkxzG5SpB
 EQnmNhyWw2aZyPb14UoGt6sfOEtOGpFAZ563yRFFI2L8S6PXh9aiB0VubacSwY6amMQHBE5ofAo6vJnO+yzMGissa8/vy6SDDx7HMJqGzMFuwixtdRGLTmuM
 mt9BgtCCdD4fkvgdeowyJ2+ibsYHNOii8ROfX78SBKpEAgr/9V0LBpPtYGo=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 10 Apr 2018, Christopher Lameter wrote:

> On Tue, 10 Apr 2018, Matthew Wilcox wrote:
>
> > __GFP_ZERO requests that the object be initialised to all-zeroes,
> > while the purpose of a constructor is to initialise an object to a
> > particular pattern.  We cannot do both.  Add a warning to catch any
> > users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> > a constructor.
>
> Can we move this check out of the critical paths and check for
> a ctor and GFP_ZERO when calling the page allocator? F.e. in
> allocate_slab()?

The ctor's are run at that point from setup_object() so it makes sense.

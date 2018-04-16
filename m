Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220864-1523921242-2-16947429211680167814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523921242; b=Kp76AJ7yVIKmEVt06Yox1U4STarEfjbV6prBIv6tGfV04wGStr
    KWGNuZ7iNuQcC72dKYRWtV3MJPDvbg6D22yQYK+zX/OkfYjaW5B+PbeuhDyPX7w4
    5ofcPyzPMm3l11lvz5dWi+Qm0G7BQUzPC6xc49/ED2lTobVcSOUr4uzglETE8wG6
    NnjDxSTVTGhuCHnKAOCYmKBAkxjOxVO0s3cYAONpaM4NqURbvmphau9QGwmnT4GE
    33wZ5pMD6gwCp/Rf/AdKfO3vCp98VlhqMtgs5z79O7UZDPDUqdJ5G8PkeJyGCnsf
    5GzbmMYKzNXiviW5pEuxP4uer/r4EuQbGXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523921242; bh=szAPqXy+BWzKgrUub2SFGaiPtAFqpcMdHYae4VK
    Ccpk=; b=kMT4VAVPF5pZmqlepKA1Ti9j6IsA8o3UFeIs+Sdo6iu2+Xi7oWZrEjL
    6oLLw1vXEkxC1Zc/R2MLQyJAGiIYsXocZJ65sYEZrtevj7z/DCx9r1mCWvszC/Et
    ZH6h8nXnLk3g+9b7raVj+SVqHx+pVa7xDT+LxlwY6seC42KgcDxYXqetRFs8+kck
    qkyqTbUQamjOW+6Kmy9n8hkLoSyAcibfQnJjFBUAAzLcxw8y9kfBToTzVtZb6T7U
    KXpD/UfngBKVRBEyT/I/DUHW6HIJhNDynbR+hHZEC5mG80lnO3p28XBtYbSAsz+p
    hTG1Rcfx7GZDjY1QRQAwFgYAlwCBT9Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHWPA1UgSy78kK4pyRYyOUqjnti9rNk69rJmrLZFmcOPzX1pEsPUT84hqGCwuvlLw9KcZcpe0k/F5AEYFz8dyO0QUWiI1EYyIYJSeuA2UAE0txR2MtZ5
    9x0nasttNRbwRiua0xsVd/7dvmOFGjULUDXQUYhTN4uB/2rjVkj2x0GOjutMuABOy+CgyYEs8MuMPcjHU9LVxXjnkVL5huNfV8VcL0awoLt1Izpx5ZOCewvE
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=UnuSTvqY3Zt2PzeBcRwA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeDPX1T (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 19:27:19 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47628 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPX1S (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 19:27:18 -0400
Date: Tue, 17 Apr 2018 09:27:03 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>
cc: Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 00/10] SWIM driver fixes
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
Message-ID: <alpine.LNX.2.21.1804160904530.8@nippy.intranet>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 11 Apr 2018, I wrote:

> This patch series has fixes for bugs in the SWIM floppy disk controller 
> driver, including an oops and a soft lockup.
> 

Apparently no-one is authorized to push this series intact.

Geert, would you please take just the first two patches?

Jens, would you please take the remaining 8 patches?

I have confirmed that no merge conflicts or bisection issues arise from 
splitting up this series in this way. However, I can re-send these patches 
as separate submission(s) if need be...

-- 

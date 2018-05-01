Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3128394-1525180954-2-16923014008476378830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525180954; b=kTsDQXlBhSDHgs1/8Vem3dI4szS/AnrP7OMj8Rf7o4TfPM8PCC
    EWgcEL+EqP8I9O9Z5ES4oPGPr+sWGT2Cl2RiuwljlX3a4yY75IIZa6/TwajxR2s9
    WES72FIIPvpmaq8ubh9Zj3q9L2nkDvy7OAXG3tSCK4tACtBBbIZdbF2Y6o+xPzou
    YPKidRtwL03AqU4wzSWnnIL63tnZyeuvdGOpfNskTj+1GaiAKWVdLJ3ODVUvgfTb
    39XXe89DU1Tn90jpxxfiVdJi1Ij0PbC5l7fvT4Grz60gWqptbWJ18vZcSQYhhXxo
    PpeD3KNJdATWYYy8Ch1vNZS+yEiWee06a6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525180954;
    bh=ICjNBp/aTPdLyL6iLKKoFbqy+G9gpALqQarnjq2y+YY=; b=hzZR22F2GXoX
    lO3KF+dBxDdZ87Msv7WPDY0ZmgW2k6CufROBlCvf6krCvAJSX8WK+m4zJ+ayyiyd
    lxYpzGqe1GfXjeU+Olcs0cORI55gqkfiiwex2vZ0i2VGhXIk0o8kLBVPrGboy9w7
    A8RTcE1CcbRdU3B0jFkXGR6U7n3klHA4gdeq2MsNN+FWixmhgT1bsbmNDo80md1q
    deFgdPw/U6pfGFFFzUxYT1uGLEOMnUqFo3E4/HU+I4Pf054uCt3FRn+BDMDUyv44
    +7DKBxGHvPDUpdrvEAXDaCcCTVHSBGaAO4maD/h9e2utQp46T3MOABrduEBm/ic2
    8vkpWIbUBw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=EU5XbUm6 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=iNPvDaMJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=EU5XbUm6 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=iNPvDaMJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIBYPRWVVYIFxRTbJs4K6drihOaWvGdJFJRLKPhkqUaBbOBhNBFVpLjxOEd3QQJNy8QsbX+Tk/pqS39/3BMM0S+oowcbCkXo4ADywHbukmdwAYby8eA2
    Y7pyC0O3C5O6QQ62qs16UI7KMUXQT4q5WQ2TLKXwUNUHog7g9Cr1d2uqJEhZ+LtKx47fge8ga9x5BpiugbiPsTXHnrliXSeQjIyN5Y4loW1wKD+AU1vZDPR+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=keWkJgPOSacA:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=bg1jY7CJ-xIyXN2IEHkA:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755658AbeEANWY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 09:22:24 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34749 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754243AbeEANWV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 09:22:21 -0400
X-Google-Smtp-Source: AB8JxZoTdmAy71c+jX6FbmlmT2nuFj3yjW1qlqhxaPUIpyw2NVks45NTU2uNaPCIGKFuXBeXhivGcQ==
Subject: Re: [PATCH 4.16 000/113] 4.16.7-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180430184015.043892819@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6412fe00-e1e3-4629-d284-694e5058bd5d@roeck-us.net>
Date: Tue, 1 May 2018 06:22:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 12:23 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.7 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:46 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 143 pass: 143 fail: 0
Qemu test results:
	total: 139 pass: 139 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter

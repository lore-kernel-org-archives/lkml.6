Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3189361-1525180733-4-841944410693887908
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
    1525180732; b=BcThkXtcKUTicvXQQpqWDZC4trixF1VP7gBSoMj3yptF18qcHT
    PdaJNqmN77+f5RcODKqq3ms2wHJFX9SqMYS7hZhVJyVEkSBAhgDp8er3vtNJnPYA
    iLizNfV4s9VqCajRu/zQebKrcPxEG7iu6knWgeJyXGq2svLcExzImxsHGnY8JMWr
    h48WplPPXfZ7f0SN7Z96IVGCtTNsP7RUYLc2KY3sB+8Z0Hurupf9dIbIJchUR8Vm
    CtxuGX4UqOyLXl0xhCfhy4p2Qgc2BvQTdtiH1/SFZtKi8hJ/UHFOZOKzFeQhmv0R
    CGIRl9WguN/tkg+FFuhQWcaaGTgdmDWRa63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525180732;
    bh=n3mWvBTTql0uG7iaMo1NJ+nYjN9lltcrY+24Opr9yeU=; b=X1HaxEY4qBCw
    jO66u3oXPm6q0JEAacuJ3UXx4VFP+0zksOVHMIcsiD6+d7Ih9eK4gjmLgV4QZ2Bf
    im19lHY3Qkw4cxEwIcu6FEE+8HllqsrMUoVjnWeGYTwiW72w5rklVrsU9NAEZliZ
    fL2y/500/MsjqU2pW8UW7WLFZtTC8SqoLdJZmOawalIc/IjSB52zKmHvsqu8cHep
    xYrfTwNzmXczF3ylqcKnIPHGFrALJrViX4m88OHwBAXq+k6FtVCuBLQ/16wSpe/X
    4LnrhExBIuaqHCcXf8HsB/noT3Lk+UPMQEgvrwd++N9pOeLyeqpaWGlzEE1IuRmB
    zlDsurWViA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=tUO6Qxo3 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=WVwvXYuo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=tUO6Qxo3 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=WVwvXYuo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP4dvJ1W5fsscLkc8zH6AxeqUsNlkUWKzBwwNxAfenCu729QMb9bN58g4xvokMXSeJGeKMSWocPuNYgJsPJolA6pBgBTYZacJ7U6xSlOZN6ABPnzSKia
    0qX9VBkbWMkkI/qtB/PAvlowJCy1cnLf+sUisJcILdgw4fZBl8gfyRa9f/mpahiuBreQau7/jPsVBNvvvFwkihXgwa4arkwLKtjCjcNtPdF7FhHCJzh9rB0q
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=vmN5MLnUJFoA:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=8nm5TD73BZbFqXAjQKIA:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeEANSt (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 09:18:49 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:44779 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeEANSs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 09:18:48 -0400
X-Google-Smtp-Source: AB8JxZquIsaxBEzILnH4TVuQZsYQm4Nzr+3rnWGMqQF/FTMI8ZnSfGQAXSjbk9p+GFUQZDYbA7Y9WA==
Subject: Re: [PATCH 3.18 00/25] 3.18.108-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180430183910.801976983@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9f8ff869-24a8-f895-a572-27aff53683ec@roeck-us.net>
Date: Tue, 1 May 2018 06:18:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 12:23 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.108 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:02 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 119 pass: 119 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter

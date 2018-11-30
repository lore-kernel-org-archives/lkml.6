Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248BB20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dQJYCmJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248BB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLAIj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:39:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42276 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tZFuy3yBqJm9Ye8+4BDpyzJjuLaEMY/lu5OqqOpBBoY=; b=dQJYCmJe5WX9lXAO5T0UR+Cns1
        OlZ8etUaG8U9v3jaj+rlJyBvUCufhV662+tlVCgfhVpi5OWlkpLGcRrQF1rguoJc1y1im/oLUy1j6
        sImQndub6R5tZ1p5Xx34OU+Vu8rcmGLbOWo3o6KTaGPrWT/B9JS8avIBTKLYyGPyb5MevcKajjvDH
        qKJkck/LDmnBZVofUvsTo3zLE1+NOFx2cv1bVk/n2pEflvKj6sa2k5yu4Iy0GBj2+Grv0UlwttbWj
        B4JR5hn8hIE5gDc8vrR4akP5jV+z+umTQd2XxqsjcLDuvsmTBC76Xa8MCD6HB5iSbTc/8gM4wjpWF
        g5evQ+hA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSqL2-0007JD-R3; Fri, 30 Nov 2018 21:28:40 +0000
Subject: Re: [PATCH RFC 01/15] MIPS: replace **** with a hug
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Joshua Kinard <kumba@gentoo.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-2-jarkko.sakkinen@linux.intel.com>
 <20181130211337.GR2217@ZenIV.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9b3103de-9153-a859-f606-66016027d590@infradead.org>
Date:   Fri, 30 Nov 2018 13:28:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181130211337.GR2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/18 1:13 PM, Al Viro wrote:
> On Fri, Nov 30, 2018 at 11:27:10AM -0800, Jarkko Sakkinen wrote:
>> In order to comply with the CoC, replace **** with a hug.
> 
> OK, that's it - from now on I'm switching to use of CoC as
> a general-purpose obscene verb.  As in "this protocol is
> completely CoCed in head", etc.
> 

ack that.

-- 
~Randy

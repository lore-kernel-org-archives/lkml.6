Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A339C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68C22098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="yDu37N0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68C22098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbeIXX2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:28:35 -0400
Received: from cock.li ([185.100.85.212]:48536 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbeIXX2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:28:34 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537809921; bh=xuKtaRgWs2ZF9yQmHIsTOZAC1JWwBXH0QBTNlYLC70Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yDu37N0bYD0MaqywriF3PpL1D8CZZhYT+y1Y8r+ODlzfUEgUfgvzlN4t0O7gt6L7k
         BQwbKTsv3+VJeDsbuXnfXPhchtei3NsuRiQvSR7td3cbHT/DKjGirWum2IMVn6efKQ
         Ryb4MX3FHBUywG5CWswm2Zzha0Q/X1S/GJvrzBgMFsw9Q5Z0xlZ1Gg1BRPr1K+RRTP
         gS4gFkEaYf1BQXRCALFKCgTauGH9mqnJJBZWJXZELSRHf/9pGIMUpcFIHnu44xpeJf
         ldGVwME80bD3J4DRTfDOtLShfpr26hkTuzZNcPRtL7HvZuAQIrlKNUZfGWs98pKcGM
         GhzK8ERKhip7w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Sep 2018 17:25:20 +0000
From:   unconditionedwitness@redchan.it
To:     fche@redhat.com, dng@lists.dyne.org
Cc:     Rik van Riel <riel@surriel.com>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
In-Reply-To: <87zhwbj8xe.fsf@redhat.com>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
 <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com>
Message-ID: <a71b227edeb0704991c33485eda3a580@redchan.it>
X-Sender: unconditionedwitness@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal is obviously to shatter the gentleman's agreement that upholds 
the opensource community and end opensource as a force within the US and 
commonwealth countries.

And it will likely succeed.

No gratis contributor wants to be told what he can say or what he can do 
"or else we won't let you give us this gift!".

FreeBSD has lost 1/2 its contributors after their woman-worshiping 
service known as the investiture of the CoC.

This will continue until all of OSS is a rotting corpse.
And then maybe some of the disaffected will revoke their license grants 
and bury the effluence.

On 2018-09-21 13:07, fche@redhat.com wrote:
> Rik van Riel <riel@surriel.com> writes:
> 
>> [...]  The goal of the code of conduct is to make the community
>> welcoming, and to help people with being a part of the Linux
>> community.  [...]
> 
> That may well be the goal.  But the proper way to evaluate policy is 
> not
> the laudability of its goals but its forseeable and/or actual effects.
> Is there any plan to evaluate the CoC empirically somehow to see if it
> accomplishes what its proponents hope?
> 
> - FChE

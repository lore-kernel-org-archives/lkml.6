Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B3C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D4B2087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D4B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeJGWdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:33:03 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:57066 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJGWdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:33:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 156FE4138A;
        Sun,  7 Oct 2018 15:25:26 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4D7SEQOjqYMl; Sun,  7 Oct 2018 15:25:26 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id F065F40EFB;
        Sun,  7 Oct 2018 15:25:19 +0000 (UTC)
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Shuah Khan <shuah@kernel.org>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com>
 <CAMuHMdWVVR_-r4K_sx-P+gDWwQ4yS7fAhA=FnL=snqxhd8J7dg@mail.gmail.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <ceb13d48-66a1-803b-ab8e-3ca86bafbd01@kernel.org>
Date:   Sun, 7 Oct 2018 09:25:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWVVR_-r4K_sx-P+gDWwQ4yS7fAhA=FnL=snqxhd8J7dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for the patch.

On 10/07/2018 02:25 AM, Geert Uytterhoeven wrote:
> Hi James,
> 
> Thanks for your patch!
> 
> On Sat, Oct 6, 2018 at 11:36 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>> From 4a614e9440148894207bef5bf69e74071baceb3b Mon Sep 17 00:00:00 2001
>> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Date: Sat, 6 Oct 2018 14:21:56 -0700
>> Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting email
>>  addresses
>>
>> The current code of conduct has an ambiguity in the it considers publishing
> 
> that
> 
>> private information such as email addresses unacceptable behaviour.  Since
>> the Linux kernel collects and publishes email addresses as part of the patch
>> process, add an exception clause for email addresses ordinarily collected by
>> the project to correct this ambiguity.
>>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 

Acked-by: Shuah Khan <shuah@kernel.org>

>> --- a/Documentation/process/code-of-conduct.rst
>> +++ b/Documentation/process/code-of-conduct.rst
>> @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants include:
>>  * Trolling, insulting/derogatory comments, and personal or political attacks
>>  * Public or private harassment
>>  * Publishing others’ private information, such as a physical or electronic
>> -  address, without explicit permission
>> +  address not ordinarily collected by the project, without explicit permission
>>  * Other conduct which could reasonably be considered inappropriate in a
>>    professional setting
> 

thanks,
-- Shuah

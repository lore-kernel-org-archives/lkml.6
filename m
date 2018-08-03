Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A53EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D182174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D182174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeHCLkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:40:07 -0400
Received: from mout02.posteo.de ([185.67.36.142]:36923 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732357AbeHCLkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:40:07 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id D8396212C0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 11:44:34 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41hhw15slRz9rxQ;
        Fri,  3 Aug 2018 11:44:33 +0200 (CEST)
Subject: Re: [PATCH 0/2] gpio: mvebu: Add support for multiple PWM lines
From:   Richard Genoud <richard.genoud@gmail.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>, aditya@kobol.io,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        gauthier@kobol.io, alban.browaeys@gmail.com,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1532114623-81911-1-git-send-email-aditya@kobol.io>
 <CACRpkdbiAkt6hT+LeRXCjWDZwjeYDF-e3sckMOWqnL2rdqLDug@mail.gmail.com>
 <87sh3vbxlf.fsf@bootlin.com> <e50f0301-f60a-0521-7d73-dcea28721365@sorico.fr>
Message-ID: <47f1a82c-d414-a3b2-94bf-b0466450703f@sorico.fr>
Date:   Fri, 3 Aug 2018 11:44:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e50f0301-f60a-0521-7d73-dcea28721365@sorico.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 11:42, Richard Genoud wrote:
> On 03/08/2018 11:36, Gregory CLEMENT wrote:
>> Hi Linus and Adita
>>  
>>  On dim., juil. 29 2018, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>>> Hoping for some review from Gergory, Ralph or Richard who all seem
>>> to use this driver!
>>
>> Would it be possible to resend the series adding me in CC?  I would
>> like to comment the patches, but unfortunately it seems that I was in
>> none of the mailing list where the series had been sent.
>>
>> I found the patches on patchwork, and started to have a look on it for
>> example, in the patch "gpio: mvebu: Add support for multiple PWM lines
>> per GPIO chip", I wonder why the id is stored as it was not used at all.
>>
>> Having the patch inlined in an email would male the review easier.
> Same for me :)
> 

Sorry, for the noise, but please use my gmail address.

Thanks !

Richard

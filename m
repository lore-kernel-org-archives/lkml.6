Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4314CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B45206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B45206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440240AbeKXCCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:02:36 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732495AbeKXCCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:02:36 -0500
Received: from [192.168.178.52] ([109.104.55.85]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MLA6m-1g9EKC46U6-00IGFS; Fri, 23 Nov 2018 16:17:43 +0100
Subject: Re: [PATCH 10/17] mailbox: bcm2835: Switch to SPDX identifier
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1541865555-7647-1-git-send-email-stefan.wahren@i2se.com>
 <2af6aa65313a9cb6c47fd4756c48f2963aa317c6.camel@v3.sk>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <b8125be3-b87d-fcd6-25aa-4bc3a9273002@i2se.com>
Date:   Fri, 23 Nov 2018 16:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2af6aa65313a9cb6c47fd4756c48f2963aa317c6.camel@v3.sk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:rzLlXC/lhWR6GuvtIuTjLjVK4S8vg51MP9ZrBamVhn+cgGIaQcM
 9BU0C+Y4YMp0A3GJfCDIg9K13moEGm6d+mwuZ7KwtvQesnd3b60cGoVgMKbIhR4R7l5PhUs
 xdsHAXGsUSHksqgmOoGAftiiWp3fqgCcNMw/nG5CYC/Qu5utk2gpw9LC6seVkShGnymOzrd
 dpMgnE5pj1SXP0RGdJ/9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T/Cq0Ula5D4=:FrdkRMy6+eZa/UtaePqrzx
 QhJgGSpqdcuA3hJ7QIGMnLO9YYHHNCk9aoEMuTcrOllA/bm+7MUL0BQeItRjybxRpZ5g5hSin
 5hlS+hlkY82ScbpCS75PDYHqnCkopQKjyR8U/XOtJUawQUFLKk0eEvT0ByuAhqTGGKq9plZS3
 JM8ZTX6vMVgeRZjX6VeHhYSVnJuc7Bm5okBlnWFHzROaAOPcAkqenoqOTXWzZ/OPiyLJdUfFt
 gxs6OEPi21QkN98T+JMYJtrO1AFMcmx7zdQM3lYqM5n8V/pnzzAsNfpzyplVW0/D9Dr245WIn
 XuPWhmH6QT0ac6Nf3CsI2FGj4GaJLowdkd03CPfKi4yaftndu/R+zygbn9zl0S87AAqeFQeQ0
 ARsNbHlnuUQFk33axnVyMJV1sZiI+u18xMl4uCeHxY+2NOViOFn6/cRfHz3ZaG6dDjUAizXUy
 8WgGN3smzpLPOzBfCdq0YWDXP/QCo42iCvd9Z3WIVkd7vNNapy00S8InwphFKqQKakB3De+75
 08oKRDqa+XgIlL1a1wmiEBvfIBEM9xGtk9FZy7NHzEDK+AGPDvxr4WqvWbKXEMLiCNX0UJdR9
 FebsBvuIt01SM5gcJvsfIEEFYng2jeTOVbRni9I7YBSwNq/+Nfd7Jp+j2FBUbA8kWbeQTCDVu
 u8X4RXM7SaijsVrjbuCvtNr/FUsXjxycrzA5Tul3DHGg7IhPadmaV4sND1x4nOWXxPK4D+dup
 U2+iaSAgUamoKJiG+hWnS9NANoPQtA3xrQ2nIvCgPi2J2YdeOPn3XilI1FW08ejBgw4DOxCKp
 nRcTz9J39mfIKH8IR84kcEH231Tvw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

Am 11.11.18 um 12:25 schrieb Lubomir Rintel:
> On Sat, 2018-11-10 at 16:59 +0100, Stefan Wahren wrote:
>> Adopt the SPDX license identifier headers to ease license compliance
>> management.
>>
>> Cc: Lubomir Rintel <lkundrak@v3.sk>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  drivers/mailbox/bcm2835-mailbox.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/mailbox/bcm2835-mailbox.c
>> b/drivers/mailbox/bcm2835-mailbox.c
>> index e92bbc5..bb3ee72 100644
>> --- a/drivers/mailbox/bcm2835-mailbox.c
>> +++ b/drivers/mailbox/bcm2835-mailbox.c
>> @@ -1,15 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>  /*
>>   *  Copyright (C) 2010,2015 Broadcom
>>   *  Copyright (C) 2013-2014 Lubomir Rintel
>>   *  Copyright (C) 2013 Craig McGeachie
>>   *
>> - * This program is free software; you can redistribute it and/or
>> modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - *
>> - * This device provides a mechanism for writing to the mailboxes,
>> - * that are shared between the ARM and the VideoCore processor
>> - *
>>   * Parts of the driver are based on:
>>   *  - arch/arm/mach-bcm2708/vcio.c file written by Gray Girling that
>> was
>>   *    obtained from branch "rpi-3.6.y" of
>> git://github.com/raspberrypi/
> Acked-by: Lubomir Rintel <lkundrak@v3.sk>
>
are you fine with this patch?

Stefan


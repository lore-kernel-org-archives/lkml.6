Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeDPHiQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 03:38:16 -0400
Received: from hub01.inventec.com ([61.220.76.161]:54569 "EHLO
        mail.inventec.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753088AbeDPHiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 03:38:15 -0400
X-Google-Smtp-Source: AIpwx49fVVzb0SFFR15DBgyJ8//4M/bJiuoi94EeBrFh4KdgGmXv1LOSVNLIfGwSoaigkM989tWa5atQudDlc5dvAHE=
MIME-Version: 1.0
In-Reply-To: <3dc71810-a743-9fe0-c8b0-7e42d8167685@axentia.se>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se> <5053d0d0-e4c5-733e-051d-b5900d05ea2b@axentia.se>
 <CADo_Z40fZaT8iRSALDv7-YaK0YD-WFph5RwmrngFbC4FzFAp9Q@mail.gmail.com> <3dc71810-a743-9fe0-c8b0-7e42d8167685@axentia.se>
From: =?UTF-8?B?Q2hlbktlbllZIOmZs+awuOeHnyBUQU8=?=
        <chen.kenyy@inventec.com>
Date: Mon, 16 Apr 2018 15:37:58 +0800
Message-ID: <CADo_Z40NYhLNLmLDPrOGoAyqvOkchpjnJZmx6sYpbEXUroC7Qw@mail.gmail.com>
Subject: Re: [PATCH linux dev-4.16 v2] i2c: muxes: pca9641: new driver
To: Peter Rosin <peda@axentia.se>
CC: <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>, Joel Stanley <joel@jms.id.au>,
        <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-DNSRBL: 
X-MAIL: IEC1-MSE-FE1.inventec.com w3G7c48F069348
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-13 15:27 GMT+08:00 Peter Rosin <peda@axentia.se>:
> On 2018-04-13 08:59, ChenKenYY 陳永營 TAO wrote:
>> Hi Peter,
>>
>> Sorry for late. Here has some event at my company which needs to pause
>> this work.
>>
>> If the status changed, I will update my patch.
>
> No worries, I just want to know how to handle my preparatory patches. If
> nothing changes, I think I'll push the first two anyway, but will hold
> off the third until there is some real need from it.
>
> Or can you perhaps make time to test a patch adding pca9641 if I adapt
> your code to my 3/3 patch? Then I can put these patches behind me.
>
I think you can push code first, I will test and update when I ready.

Thanks,
Ken

> Cheers,
> Peter

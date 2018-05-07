Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeEGJdF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:33:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37419 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeEGJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:32:59 -0400
X-Google-Smtp-Source: AB8JxZoDWgKBciK2Z44AVWfixoFLvS1t8GpO0q0EOxGHBIecdi7U0OLs4kRQiNrIpmEjX4hL1ayWGA==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1525663384.5064.1.camel@gmx.de>
Date: Mon, 7 May 2018 11:32:56 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Message-Id: <4299ECA6-4320-426E-B33A-F6CC1C1C5864@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
 <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
 <1525532191.5406.15.camel@gmx.de>
 <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
 <1525660992.5105.1.camel@gmx.de> <1525663384.5064.1.camel@gmx.de>
To: Mike Galbraith <efault@gmx.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w479XA6Q009040



> Il giorno 07 mag 2018, alle ore 05:23, Mike Galbraith <efault@gmx.de> ha scritto:
> 
> On Mon, 2018-05-07 at 04:43 +0200, Mike Galbraith wrote:
>> On Sun, 2018-05-06 at 09:42 +0200, Paolo Valente wrote:
>>> 
>>> I've attached a compressed patch (to avoid possible corruption from my
>>> mailer).  I'm little confident, but no pain, no gain, right?
>>> 
>>> If possible, apply this patch on top of the fix I proposed in this
>>> thread, just to eliminate possible further noise. Finally, the
>>> patch content follows.
>>> 
>>> Hoping for a stroke of luck,
>> 
>> FWIW, box didn't survive the first full build of the morning.
> 
> Nor the second.
> 

Great, finally the first good news!

Help from blk-mq experts would be fundamental here.  To increase the
chances to get it, I'm going to open a new thread on this.  In that
thread I'll ask you to provide an OOPS or something, I hope it is now
easier for you to get it.

Thanks,
Paolo

> 	-Mike

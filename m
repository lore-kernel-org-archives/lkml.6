Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeEGSD0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:03:26 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36039 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbeEGSDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:03:12 -0400
X-Google-Smtp-Source: AB8JxZqlNAFYX8jhnP2UulBXmsNVRxvR7xHIGN+H5lMsGd0+HZ1yYNsW1kW6QpTFYBOxkAF3la31rw==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1525687297.26987.1.camel@gmx.de>
Date: Mon, 7 May 2018 20:03:10 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Message-Id: <A25FE1D8-71DF-4781-A0A6-67DDD0AB5C44@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
 <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
 <1525532191.5406.15.camel@gmx.de>
 <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
 <1525672597.5064.3.camel@gmx.de>
 <1723D46D-579A-4C5A-BCC1-6ABAA6E7C3FB@linaro.org>
 <1525687297.26987.1.camel@gmx.de>
To: Mike Galbraith <efault@gmx.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w47I3VpT009833



> Il giorno 07 mag 2018, alle ore 12:01, Mike Galbraith <efault@gmx.de> ha scritto:
> 
> On Mon, 2018-05-07 at 11:27 +0200, Paolo Valente wrote:
>> 
>> 
>> Where is the bug?
> 
> Hm, seems potent pain-killers and C don't mix all that well.
> 

I'll try to keep it in mind, and I do wis you to get well soon.

Thanks,
Paolo

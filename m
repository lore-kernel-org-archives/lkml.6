Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEEKjt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:39:49 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:51585 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEEKjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:39:48 -0400
X-Google-Smtp-Source: AB8JxZpLPzCs/90LUf4Gdv4yQcEPh7RQQ5w2D+yzc4ipV8X6gFV40dMdfXY7n9dOsgRYPtqy8Mip9w==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1525508378.5406.6.camel@gmx.de>
Date: Sat, 5 May 2018 12:39:44 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Message-Id: <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
To: Mike Galbraith <efault@gmx.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w45Adtfs000887



> Il giorno 05 mag 2018, alle ore 10:19, Mike Galbraith <efault@gmx.de> ha scritto:
> 
> On Fri, 2018-05-04 at 21:46 +0200, Mike Galbraith wrote:
>> Tentatively, I suspect you've just fixed the nasty stalls I reported a
>> while back.
> 
> Oh well, so much for optimism.  It took a lot, but just hung.

Yep, it'd have been a lot of luck, being your hang related to
different operations from those touched by this fix.  Maybe
time-before-failure stretched because your system suffered from the
illness cured by this fix too.

BTW, if you didn't run out of patience with this permanent issue yet,
I was thinking of two o three changes to retry to trigger your failure
reliably.  In case of success, I could restart racking my brains from
there.

Thanks,
Paolo

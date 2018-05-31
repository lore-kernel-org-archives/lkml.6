Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755477AbeEaOu5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:50:57 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37118 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755352AbeEaOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:50:49 -0400
X-Google-Smtp-Source: ADUXVKJxFtYC8hLJFVruZTPg8Ivrbv6fBD8tnsXPXmYSB6af0TU2rJym3zG19DG/NsoPo+fktYa7zg==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX 0/3] three fixes for the function
 bfq_requests_merged
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <d2f92f58-598f-d75c-8120-71cf269738fe@kernel.dk>
Date: Thu, 31 May 2018 16:50:46 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        oleksandr@natalenko.name, filippo.muzzini@outlook.it
Message-Id: <3C2F9AF5-C988-4D53-A24C-2D69A71F9F29@linaro.org>
References: <20180531132313.2986-1-paolo.valente@linaro.org>
 <d2f92f58-598f-d75c-8120-71cf269738fe@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VEpPeR019791



> Il giorno 31 mag 2018, alle ore 16:48, Jens Axboe <axboe@kernel.dk> ha scritto:
> 
> On 5/31/18 7:23 AM, Paolo Valente wrote:
>> Hi Jens,
>> this series fixes three bugs in bfq_requests_merged. In more detail:
>> 
>> - two linked bugs, with the first (critical: wrong lock) hidden by the
>>  second (less critical: wrong check that made the body of the
>>  function not be executed at all)
>> - a rather minor bug: superflous code
> 
> Patch #2 doesn't apply on for-4.18/block.

Yep, it gave some problems to me too, because we happened to move this
patch around by email.

> I hand applied it, all
> 3 are queued up now.
> 

Thanks for the patience and for queueing these fixes.

Paolo

> -- 
> Jens Axboe
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753132AbeENRhy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:37:54 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:37396 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752405AbeENRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:37:52 -0400
X-Google-Smtp-Source: AB8JxZpmSbaeg8z5xBcvRrywyvFyeTMNcSr/IHWy87CkCkkFhlWHsuOixW6CSpSlTqZIDJ04TBJM5Q==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <4ea9999a-e316-f0bc-a99f-70cd0e901e55@kernel.dk>
Date: Mon, 14 May 2018 19:37:48 +0200
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Message-Id: <121C9095-504D-42BB-AD23-C7733E2849DF@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <d534de4765c0fbcc7bcd858c1d2f40391ece19ac.camel@wdc.com>
 <8B9DC3A2-0DB0-4EEB-AFB2-C4D6560B7A4A@linaro.org>
 <4ea9999a-e316-f0bc-a99f-70cd0e901e55@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EHc02W020393



> Il giorno 14 mag 2018, alle ore 19:31, Jens Axboe <axboe@kernel.dk> ha scritto:
> 
> On 5/14/18 11:16 AM, Paolo Valente wrote:
>> 
>> 
>>> Il giorno 10 mag 2018, alle ore 18:14, Bart Van Assche <bart.vanassche@wdc.com> ha scritto:
>>> 
>>> On Fri, 2018-05-04 at 19:17 +0200, Paolo Valente wrote:
>>>> When invoked for an I/O request rq, [ ... ]
>>> 
>>> Tested-by: Bart Van Assche <bart.vanassche@wdc.com>
>>> 
>>> 
>>> 
>> 
>> Any decision for this fix, Jens?
> 
> Guess I didn't reply, but I did commit this on Thursday.
> 

Great, thank you!

Paolo

> -- 
> Jens Axboe
> 

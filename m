Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeENRRB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:17:01 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39717 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754318AbeENRQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:16:57 -0400
X-Google-Smtp-Source: AB8JxZq5wFvduYcu+OkUMegZpyBQAX53FVTa0q4Fwm2Qpk5fZMCHqq0269VKXjjWALfUut3cQyCdKg==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <d534de4765c0fbcc7bcd858c1d2f40391ece19ac.camel@wdc.com>
Date: Mon, 14 May 2018 19:16:54 +0200
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Message-Id: <8B9DC3A2-0DB0-4EEB-AFB2-C4D6560B7A4A@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <d534de4765c0fbcc7bcd858c1d2f40391ece19ac.camel@wdc.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EHH7f1015745



> Il giorno 10 mag 2018, alle ore 18:14, Bart Van Assche <bart.vanassche@wdc.com> ha scritto:
> 
> On Fri, 2018-05-04 at 19:17 +0200, Paolo Valente wrote:
>> When invoked for an I/O request rq, [ ... ]
> 
> Tested-by: Bart Van Assche <bart.vanassche@wdc.com>
> 
> 
> 

Any decision for this fix, Jens?

Thanks,
Paolo

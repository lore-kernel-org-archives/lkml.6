Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbeDDQog (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:44:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37216 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDDQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:44:35 -0400
X-Google-Smtp-Source: AIpwx4+jKUD6AigS1sdKJZV5z6ATkvYqh8R6c1hgLqdX+QhYeGiI+Z3zeg5PbLepGF7W9+om5Lnqnm3EOCA5YocbLfU=
MIME-Version: 1.0
In-Reply-To: <20180329100146.GA23906@kroah.com>
References: <20180218170629.6045-1-paweldembicki@gmail.com>
 <20180218171927.6414-1-paweldembicki@gmail.com> <20180314135902.GA21622@kroah.com>
 <CAJN1Kkzsys9XAJcDS2-CvE5+Z+z=kkvi6YN96G+kufqh9xakag@mail.gmail.com>
 <20180317115556.GA17545@kroah.com> <CAJN1KkyrJLBVtzjnE69v-NNed3rjrXt+o46ALnN+wurHzecPTw@mail.gmail.com>
 <20180329100146.GA23906@kroah.com>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Wed, 4 Apr 2018 18:44:13 +0200
Message-ID: <CAJN1Kky2TzGaG0eRv3vRf1Qy3e8MWGcHeimX7KmoEXQKY2jyYg@mail.gmail.com>
Subject: Re: [PATCH] w1: gpio: fix problem with platfom data in w1-gpio
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34Gig5I029340

2018-03-29 12:01 GMT+02:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Thu, Mar 29, 2018 at 11:47:25AM +0200, Paweł Dembicki wrote:
>> 2018-03-17 12:55 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
>>
>> > Where is this patch supposed to go?  Is this a stable backport patch, or
>> > something to go into Linus's tree?
>>
>> I tested it in 4.9 and 4.14 kernels in OpenERT. So it is a stable
>> backport patch.
>
> What commit is being backported.
>

This commit resolve problem in mainline:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0fc62a6552f3d9c21e73cc65844f9aad1892cf7

>> In current release this bug is fixed because w1-gpio use gpiod.
>
> Then why can we not just use the actual patch that fixes this?


I think, mainline commit is big change. My patch is answer for problem
in stable kernels, which is resolved in mainline.


>
>> Sorry. This was my first patch.
>
> Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to submit a patch for the stable tree.
>
> thanks,
>
> greg k-h


Pawel Dembicki

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeEPObO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:31:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:56074 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeEPObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:31:12 -0400
X-Google-Smtp-Source: AB8JxZptVQH2YtDkHudh1a3R/xylpzZzTIr5JorJXRZpp6cjqaOspMVZ5QoAZL1m6UD7Ljx4qnjkmlHxJPkxKYFFuXo=
MIME-Version: 1.0
In-Reply-To: <6AA622D1-DA8C-4C58-8EAE-555989E69149@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com> <CACRpkdbk0rNZ3cUN_noqVtNYgDrydGtCCn2fk7yqVRPoroYqpA@mail.gmail.com>
 <6AA622D1-DA8C-4C58-8EAE-555989E69149@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 16:31:10 +0200
Message-ID: <CACRpkda_nrL8HQL3y+tvHKff+5zKykd3Ym1waEm=JC1tFQbbcw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] pcal6524 extensions and fixes for pca953x driver
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kumar Gala <galak@codeaurora.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Alexandre Courbot <gnurou@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 3:32 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> Am 16.05.2018 um 13:53 schrieb Linus Walleij <linus.walleij@linaro.org>:
>> On Sat, Apr 28, 2018 at 6:31 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>
>>> V5:
>>> * fix wrong split up between patches 1/7and 2/7.
>>
>> I applied patches 1, 2, 3 so we get some movement on the patch
>> set and not too much for you to rebase.
>
> thanks!
>
> Well, I already had edited the commit messages for resending...
>
>>
>> It's fine to just resend the rest next time.
>
> There is only one point open before resending:
>
> what is the preferred style to be used for PCAL_GPIO_MASK?
>
> * GENMASK(4, 0)
> * or 0x1f

No strong opinion... sorry. Whatever you & the other driver
contributors are most convenient with.

Yours,
Linus Walleij

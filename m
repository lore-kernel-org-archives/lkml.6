Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeEPL5C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:57:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55595 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeEPL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:56:57 -0400
X-Google-Smtp-Source: AB8JxZrmArOQSOlR+sBQ8xFQRO2DTKoUUwKg7Y+ULDGMy1ZhLFYYDg/cdJgCXnrMeYY8bnxQ+2yLUvVmfS6RCcG2p3w=
MIME-Version: 1.0
In-Reply-To: <CACRpkdbk0rNZ3cUN_noqVtNYgDrydGtCCn2fk7yqVRPoroYqpA@mail.gmail.com>
References: <cover.1524933096.git.hns@goldelico.com> <CACRpkdbk0rNZ3cUN_noqVtNYgDrydGtCCn2fk7yqVRPoroYqpA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 13:56:56 +0200
Message-ID: <CACRpkdZixSORyofhK5pOWQJeYN5TUwPkCKCwsqd6xVOBTkcWTg@mail.gmail.com>
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

On Wed, May 16, 2018 at 1:53 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Apr 28, 2018 at 6:31 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
>> V5:
>> * fix wrong split up between patches 1/7and 2/7.
>
> I applied patches 1, 2, 3 so we get some movement on the patch
> set and not too much for you to rebase.
>
> It's fine to just resend the rest next time.

Oh also 6,7 was ripe. So only two patches to resend :)

Yours,
Linus Walleij

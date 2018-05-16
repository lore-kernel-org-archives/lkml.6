Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeEPOhj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:37:39 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:23451 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeEPOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:37:37 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WivdN1GDmY"
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 0/7] pcal6524 extensions and fixes for pca953x driver
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CACRpkda_nrL8HQL3y+tvHKff+5zKykd3Ym1waEm=JC1tFQbbcw@mail.gmail.com>
Date: Wed, 16 May 2018 16:37:23 +0200
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
Message-Id: <9213FFC0-3C2B-447D-AA2C-55D7F93CFA27@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com> <CACRpkdbk0rNZ3cUN_noqVtNYgDrydGtCCn2fk7yqVRPoroYqpA@mail.gmail.com> <6AA622D1-DA8C-4C58-8EAE-555989E69149@goldelico.com> <CACRpkda_nrL8HQL3y+tvHKff+5zKykd3Ym1waEm=JC1tFQbbcw@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GEbiUo009284


> Am 16.05.2018 um 16:31 schrieb Linus Walleij <linus.walleij@linaro.org>:
> 
> On Wed, May 16, 2018 at 3:32 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> Am 16.05.2018 um 13:53 schrieb Linus Walleij <linus.walleij@linaro.org>:
>>> On Sat, Apr 28, 2018 at 6:31 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> 
>>>> V5:
>>>> * fix wrong split up between patches 1/7and 2/7.
>>> 
>>> I applied patches 1, 2, 3 so we get some movement on the patch
>>> set and not too much for you to rebase.
>> 
>> thanks!
>> 
>> Well, I already had edited the commit messages for resending...
>> 
>>> 
>>> It's fine to just resend the rest next time.
>> 
>> There is only one point open before resending:
>> 
>> what is the preferred style to be used for PCAL_GPIO_MASK?
>> 
>> * GENMASK(4, 0)
>> * or 0x1f
> 
> No strong opinion... sorry. Whatever you & the other driver
> contributors are most convenient with.

Ok, then let's keep the GENMASK(4, 0) since nobody did complain
about it.

BR and thanks,
Nikolaus

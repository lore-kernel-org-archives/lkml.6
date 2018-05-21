Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeEULYh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:24:37 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43152 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeEULYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:24:34 -0400
X-Google-Smtp-Source: AB8JxZpaO/Z6k2ajw52Lb1M//R2sPQZNreuO/q0S1G4vOwNqmQzrXXtikogXg2S6B8GtE4QJ+izQqVz9wuxxY5gn18w=
MIME-Version: 1.0
In-Reply-To: <20180517050611.GG20254@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-20-linus.walleij@linaro.org> <20180517050611.GG20254@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 May 2018 13:24:32 +0200
Message-ID: <CACRpkdZnY+gKMarQkgp1Csn4ZFfYoC6WOV2XNkV1EKyx_bMKrw@mail.gmail.com>
Subject: Re: [PATCH 19/19 v3] ARM: s3c64xx: Tidy up handling of regulator GPIO lookups
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 7:06 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, May 14, 2018 at 10:06:40AM +0200, Linus Walleij wrote:
>> From: Charles Keepax <ckeepax@opensource.cirrus.com>
>>
>> Rather than unconditionally registering the GPIO lookup table only do so
>> for devices that require it.
>>
>> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>> [Fixed up to also handle wm5102 and wm5102 reva]
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v2->v3:
>> - Including this in my patch series.
>> ---
>>  arch/arm/mach-s3c64xx/mach-crag6410-module.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> You need to send this patch to the Samsung platform maintainers...

Right. As it sits on top of the other patches we can take it on
a side track later anyways through their tree.

Yours,
Linus Walleij

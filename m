Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936934AbeBUQ0l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:26:41 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:40441 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936632AbeBUQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:26:37 -0500
X-Google-Smtp-Source: AG47ELtI1YE5PgywZuQ1fxzo35ypqaie7naPd+aSmt04tmCuWNnysSRc2EBCbPuppPpPtK+6XQKUV/TZhfSKVjmXRUM=
MIME-Version: 1.0
In-Reply-To: <CAHp75VfFoU3sM9oE=NTZQRetsngsf_c0aZUggevb1StFXO6rxw@mail.gmail.com>
References: <cover.1519228823.git.gdouezangrard@gmail.com> <4c78b9aa890eebda69bbfff71b5de04b574bef49.1519228823.git.gdouezangrard@gmail.com>
 <CAHp75VfFoU3sM9oE=NTZQRetsngsf_c0aZUggevb1StFXO6rxw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 18:26:36 +0200
Message-ID: <CAHp75VcxGy04OsEfhaqGV7+U4NcoyygOiu21AzhKCrX9RSMukw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] platform/x86: topstar-laptop: replace licence text
 with SPDX tag
To: =?UTF-8?Q?Guillaume_Dou=C3=A9zan=2DGrard?=
        <gdouezangrard@gmail.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LGQiYQ008852

On Wed, Feb 21, 2018 at 6:26 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Feb 21, 2018 at 6:10 PM, Guillaume Douézan-Grard
> <gdouezangrard@gmail.com> wrote:
>> Replace verbatim GPLv2 license copy with SPDX identifier.
>
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>
> It doesn't much.

s/much/match/

>
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko

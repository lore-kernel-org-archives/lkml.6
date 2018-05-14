Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeENGEO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 02:04:14 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33335 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeENGEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 02:04:13 -0400
X-Google-Smtp-Source: AB8JxZq4kKR4fmJFCv6Vu7oCtsj7GdLjxMsDkUOHoEH9mpQkpyVaVcvVQWH1+9dJZmckoYKRrM1FKVRGWoRZEANZLFY=
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcasYujyBAN7zbsmE0rZXquP2dL_9fr1ZM+nCun3G-UrA@mail.gmail.com>
References: <20180422230742.3729-1-linus.walleij@linaro.org>
 <20180422230742.3729-5-linus.walleij@linaro.org> <CAJKOXPcasYujyBAN7zbsmE0rZXquP2dL_9fr1ZM+nCun3G-UrA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 08:04:12 +0200
Message-ID: <CACRpkdZryM_1guLCZYucdE8eW8aR5EfkTYT81Ej9LxL2UaxDQA@mail.gmail.com>
Subject: Re: [PATCH 05/18 v2] regulator: max77686: Pass descriptor instead of
 GPIO number
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 8:46 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Both my previous comments remain not addressed:
> 1. Name: This is also for bucks so how about naming it "max77686-regulator"?
> 2. Error path here is not equivalent to old code and results in using
> default driver's init data. Instead I would prefer to just ignore the
> gpio.

Sorry for missing these :(

I fixed it up for v3.

Yours,
Linus Walleij

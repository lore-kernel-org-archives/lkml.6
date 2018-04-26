Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754282AbeDZINK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:13:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41774 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753067AbeDZIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:12:59 -0400
X-Google-Smtp-Source: AIpwx48XuMF90Wn6ZYrmvhiCiKwgei++9cMZYSQHOx3/mSCteze3piferDsG1MI9IZAnxSVWskIBue7NNaiFjY+ykcw=
MIME-Version: 1.0
In-Reply-To: <7bac44aef748c61863fd9651ef3c52b4e51c511a.1522392153.git.baolin.wang@linaro.org>
References: <bdaaa8823cc3aef44352ee867fb6274278f2a2a9.1522392153.git.baolin.wang@linaro.org>
 <7bac44aef748c61863fd9651ef3c52b4e51c511a.1522392153.git.baolin.wang@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Apr 2018 10:12:54 +0200
Message-ID: <CACRpkdYqZbU8q_gRz8rUhtA81F=jKFDYJ1S+6oBhJNsa7Y6kaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: pmic_eic: Add edge trigger emulation for PMIC EIC
To: Baolin Wang <baolin.wang@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 9:02 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch will toggle the EIC level to emulate the edge trigger to
> support PMIC EIC egdge trigger function, which is required by gpio-keys
> driver.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Patch applied.

Also adding Uwe to this thread so he can have a look.

Yours,
Linus Walleij

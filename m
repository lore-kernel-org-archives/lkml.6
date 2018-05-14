Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeENJ2T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbeENJ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:28:18 -0400
X-Google-Smtp-Source: AB8JxZousZzcWtEh/uipENgvrQhYRV3jy4XR/MUJh76y9R/Av1dl06whLsEdu5vmQRuddE3HLlSimOcdLvhbO9bPPFc=
MIME-Version: 1.0
In-Reply-To: <20180514080640.12515-6-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org> <20180514080640.12515-6-linus.walleij@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 14 May 2018 11:28:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcRzODbD0bte=hzjkFHHnnzB9t41Csx0hDjrqSfY9AwKQ@mail.gmail.com>
Message-ID: <CAJKOXPcRzODbD0bte=hzjkFHHnnzB9t41Csx0hDjrqSfY9AwKQ@mail.gmail.com>
Subject: Re: [PATCH 05/19 v3] regulator: max77686: Pass descriptor instead of
 GPIO number
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:06 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> Instead of passing a global GPIO number, pass a descriptor looked
> up from the device tree configuration node.
>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Name the regulator "max77686-regulator"
> - Set the regulator to NULL on erroneous lookup, restoring the
>   old init data lookup behaviour.
> ChangeLog v1->v2:
> - Rebase the patch on the other changes.
> ---
>  drivers/regulator/max77686-regulator.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested on Odroid U3 (with max77686 although not using any GPIOs for
regulators, so at least default paths are not broken):
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

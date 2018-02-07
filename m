Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeBGMKf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:10:35 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38680 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753956AbeBGMKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:10:33 -0500
X-Google-Smtp-Source: AH8x225gDE3CStT6KYu2379Tvf04RP84cObafNbn4txKJLn+o6PKruRKD/XAiDABUgOweessJ7bVR8ASmApmKmvn+IY=
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-15-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-15-ulfalizer@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2018 13:10:32 +0100
Message-ID: <CACRpkdaB2gUd8EHMFV1MJo9rF2KxhYYxJnMjHciw5R_akTv-MQ@mail.gmail.com>
Subject: Re: [PATCH 14/20] iio: gyro: mpu3050: Remove INPUT_MPU3050 dep. from I2C
To: Ulf Magnusson <ulfalizer@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>, tfiga@chromium.org,
        paul.burton@mips.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Vineet Gupta <vgupta@synopsys.com>, mgorman@techsingularity.net,
        Christoph Hellwig <hch@lst.de>, mina86@mina86.com,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Paul Mackerras <paulus@ozlabs.org>, Will Deacon <will.deacon@arm.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:

> The INPUT_MPU3050 symbol was removed in commit b1fe0cf06f92 ("Input:
> delete MPU3050 driver").
>
> Remove the negative dependency on it from the MPU3050_I2C symbol. It is
> always satisfied now.
>
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Jonathan, please pick this up to IIO!

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeBQKAE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:00:04 -0500
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:53358 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751070AbeBQKAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:00:01 -0500
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 17 Feb 2018 10:59:59 +0100
X-ME-IP: 90.55.201.22
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <mike@compulab.co.il>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 18/21] regulator: fixed/gpio: Pull inversion/OD into gpiolib
In-Reply-To: <20180212131717.27193-19-linus.walleij@linaro.org> (Linus
        Walleij's message of "Mon, 12 Feb 2018 14:17:14 +0100")
References: <20180212131717.27193-1-linus.walleij@linaro.org>
        <20180212131717.27193-19-linus.walleij@linaro.org>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
X-URL: http://belgarath.falguerolles.org/
Date: Sat, 17 Feb 2018 10:59:57 +0100
Message-ID: <87a7w87x7m.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> This pushes the handling of inversion semantics and open drain
> settings to the GPIO descriptor and gpiolib. All affected board
> files are also augmented.

Hi Linus,

Could we split the patch into chunks, one for i2c, one for pxa, etc ...
I fear that exceptionally I have a couple of competing patches for the pxa tree,
and a conflict might arise between 3 trees (I2C, MTD, PXA).

Otherwise it looks good for the PXA part.

Cheers.

-- 
Robert

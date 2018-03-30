Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeC3Hdy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:33:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50604 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeC3Hdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:33:53 -0400
X-Google-Smtp-Source: AIpwx49PHjGF48xpqOlAuTEPOpdqKX6M97XniA9pELXPEGCvXMlm1UXRXHAB6JkOXVeeyXdy8K8Jgg==
MIME-Version: 1.0
In-Reply-To: <20180330072243.19368-1-ssuloev@orpaltech.com>
References: <20180330072243.19368-1-ssuloev@orpaltech.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 30 Mar 2018 15:33:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v642R=zNmLLz2t4B=xB9wu9yefRs6WG_5fPkuD1-9vLTQg@mail.gmail.com>
Message-ID: <CAGb2v642R=zNmLLz2t4B=xB9wu9yefRs6WG_5fPkuD1-9vLTQg@mail.gmail.com>
Subject: Re: [PATCH 0/6] spi: Add support for DMA transfers in sun6i SPI driver
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 3:22 PM, Sergey Suloev <ssuloev@orpaltech.com> wrote:
> The following patchset provides corrections for PIO-mode
> and support for DMA transfers in sun6i SPI driver.

Is this the same series you sent 12 hours ago? What's different?
Please version your patch series and provide a changelog.

ChenYu

> Sergey Suloev (6):
>   spi: sun6i: coding style/readability improvements
>   spi: sun6i: handle chip select polarity flag
>   spi: sun6i: restrict transfer length in PIO-mode
>   spi: sun6i: use completion provided by SPI core
>   spi: sun6i: introduce register set/unset helpers
>   spi: sun6i: add DMA transfers support
>
>  drivers/spi/spi-sun6i.c | 501 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 378 insertions(+), 123 deletions(-)
>
> --
> 2.16.2
>

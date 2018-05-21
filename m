Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbeEULgg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:36:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36244 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeEULga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:36:30 -0400
X-Google-Smtp-Source: AB8JxZqOOVro3EwrxDYvbnNcn9EFnAk0tszEhYdWdKLWAIFEzHTzW4OpiZDg9xy5ahnf/6RvJlNEpoTGqzSpltzha3Q=
MIME-Version: 1.0
In-Reply-To: <20180515095748.6794-1-jbrunet@baylibre.com>
References: <20180515095748.6794-1-jbrunet@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 21 May 2018 13:36:29 +0200
Message-ID: <CAPDyKFqxaqHZ6D_kY8P53WmXOyL4xj4UGOyfT8Nb2W1pPKxBEg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: meson-gx: add device reset
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2018 at 11:57, Jerome Brunet <jbrunet@baylibre.com> wrote:
> This patchset adds the optional reset of the meson-gx mmc controller and
> the related documentation.
>
> Changes since v1: [0]
>  * Correct typo in the documentation
>  * Separate code and documentation patches
>  * Error on reset failure.
>
> [0]: https://lkml.kernel.org/r/20180426103817.12675-1-jbrunet@baylibre.com
>
> Jerome Brunet (2):
>   dt-bindings: mmc: meson-gx: add reset
>   mmc: meson-gx: add device reset
>
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 2 ++
>  drivers/mmc/host/meson-gx-mmc.c                            | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> --
> 2.14.3
>

Thanks, applied for next!

Kind regards
Uffe

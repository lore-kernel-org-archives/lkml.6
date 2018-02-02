Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeBBWs5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:48:57 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38595 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbeBBWsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:48:45 -0500
X-Google-Smtp-Source: AH8x2273QA5X34NbM0XKt00j1ZogyCMdTut5m6tIRKZeYcmmWtyGxsRkt6sk+7MyQowCHhzoMSL/4J7O1oMnMbBCuXE=
MIME-Version: 1.0
In-Reply-To: <1517588406-3295-3-git-send-email-daniel.baluta@nxp.com>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com> <1517588406-3295-3-git-send-email-daniel.baluta@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Feb 2018 20:48:44 -0200
Message-ID: <CAOMZO5BOq6XN8TMXLSW5QPtLYg7EghkkK0bP4uxMja2onnK7iw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 2/2] ASoC: ak5558: Add bindings for AK5558 ADC
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, daniel.baluta@gmail.com,
        shengjiu.wang@nxp.com, linux-kernel <linux-kernel@vger.kernel.org>,
        wakasugi.jb@om.asahi-kasei.co.jp, linux-imx@nxp.com,
        cosmin.samoila@nxp.com, Mihai Serban <mihai.serban@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

You missed to add the dt maintainer, Rob Herring.

On Fri, Feb 2, 2018 at 2:20 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Please add a commit log.

> ---
>  Documentation/devicetree/bindings/sound/ak5558.txt | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
> new file mode 100644
> index 0000000..61c85568
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak5558.txt
> @@ -0,0 +1,23 @@
> +AK5558 8 channel differential 32-bit delta-sigma ADC
> +
> +This device supports I2C mode only.
> +
> +Required properties:
> +
> +- compatible : "asahi-kasei,ak5558"
> +- reg : The I2C address of the device for I2C.

No need for repeating "I2C" in this phrase.

"- reg : The I2C address of the device." would be better.

> +Optional properties:
> +
> +- reset-gpios: A GPIO specifier for the GPIO controlling
> +       the power down & reset pin.

No need for repeating "GPIO" in this phrase.

"- reset-gpios: A GPIO specifier for the the power down & reset pin."
would be better.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeBEU0r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:26:47 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35792 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBEU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:26:40 -0500
X-Google-Smtp-Source: AH8x227lrn/bDbUVFjNb/KY8fpMYfQn1awX52d1WYUA8wMQJ42Z9sSvsSLuz1QAxJpCrYLFpbOVDkKYXrdCxA75NPR0=
MIME-Version: 1.0
In-Reply-To: <1517850115-24340-3-git-send-email-daniel.baluta@nxp.com>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com> <1517850115-24340-3-git-send-email-daniel.baluta@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Feb 2018 18:26:38 -0200
Message-ID: <CAOMZO5D_5E9H6dJw8ivOgvOqxNvAZ72qhADCoG7VAZ7QwiOcUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: ak5558: Add bindings for AK5558 ADC
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wakasugi.jb@om.asahi-kasei.co.jp, shengjiu.wang@nxp.com,
        Mihai Serban <mihai.serban@gmail.com>, cosmin.samoila@nxp.com,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 3:01 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> Document the bindings for AK5558 ADC.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/ak5558.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
> new file mode 100644
> index 0000000..7d67ca6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak5558.txt
> @@ -0,0 +1,22 @@
> +AK5558 8 channel differential 32-bit delta-sigma ADC
> +
> +This device supports I2C mode only.
> +
> +Required properties:
> +
> +- compatible : "asahi-kasei,ak5558"
> +- reg : The I2C address of the device.
> +
> +Optional properties:
> +
> +- reset-gpios: A GPIO specifier for the power down & reset pin.
> +
> +Example:
> +
> +&i2c {
> +       ak5558: adc@10 {

If I understood well Rob's suggestion was to make it only:

adc@10 {

Other than that:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934701AbeBLMrI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:47:08 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:34904 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeBLMrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:47:06 -0500
X-Google-Smtp-Source: AH8x225LWsJGOo6iSqmX6+HPtExFe1eRqaR+h6qSp2a4pyXNwDTWEThuB1HfNvm1eu3iSuaOvDye4Dz8NYtIqqxngqI=
MIME-Version: 1.0
In-Reply-To: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
References: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 12 Feb 2018 10:47:05 -0200
Message-ID: <CAOMZO5CMQKRwGMo=FyY3GkFT+A_A0epq-K7K2Wccv1ihJ3Qw8w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK4458 DAC driver
To: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wakasugi.jb@om.asahi-kasei.co.jp, shengjiu.wang@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mihai Serban <mihai.serban@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mihai Serban <mihai.serban@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 11:20 AM, Cosmin-Gabriel Samoila
<cosmin.samoila@nxp.com> wrote:
> The AK4458 is a 32-bit 8ch Premium DAC that corresponds
> to a 768kHz PCM input and an 11.2MHz DSD input at maximum.
> It supports I2S, DSD and TDM modes with 24 or 32 bit MSB
> or 16, 24, 32 LSB formats. Its datasheet is available here:
> https://www.akm.com/akm/en/file/datasheet/AK4458VN.pdf
>
> Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>

Please sync with Daniel's recent codec submission.

Many of the feedback provided there applies to this code as well.

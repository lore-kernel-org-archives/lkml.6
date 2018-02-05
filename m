Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeBEU15 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:27:57 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36912 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBEU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:27:48 -0500
X-Google-Smtp-Source: AH8x225QHAZBTIEVBDOBwY1q9wR220bL/ys4qi8qG6CR3/yCAVE6RQbxI7yb3JYMqa1Ywcu4dDsLqIyeA+bpUf9rXKo=
MIME-Version: 1.0
In-Reply-To: <1517850115-24340-2-git-send-email-daniel.baluta@nxp.com>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com> <1517850115-24340-2-git-send-email-daniel.baluta@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Feb 2018 18:27:47 -0200
Message-ID: <CAOMZO5AvGLQfAAQsRzud15DmG21eyuCR9SOdSBD__VYDHxPZzg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for AK5558 ADC driver
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wakasugi.jb@om.asahi-kasei.co.jp, shengjiu.wang@nxp.com,
        Mihai Serban <mihai.serban@gmail.com>, cosmin.samoila@nxp.com,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mihai Serban <mihai.serban@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 3:01 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
> for digital audio systems.
>
> Datasheet is available at:
>
> https://www.akm.com/akm/en/file/datasheet/AK5558VN.pdf
>
> Initial patch includes support for normal and TDM modes.
>
> Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> [initial coding for 3.18 kernel]
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> [cleanups and porting to 4.9 kernel]
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> [tdm support]
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> [pm support, cleanups and porting to latest kernel]

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

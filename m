Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBFCQV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:16:21 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:46081 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeBFCQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:16:11 -0500
X-Google-Smtp-Source: AH8x227I89EbO9ex8O/bpdpUq9D275eeaUMLZ2kdx/CDA3fJ0nBIwqDItOt2ZPjU78FP41bnQ4Udnifza/LhGtnf9aQ=
MIME-Version: 1.0
In-Reply-To: <CAOMZO5D_5E9H6dJw8ivOgvOqxNvAZ72qhADCoG7VAZ7QwiOcUw@mail.gmail.com>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
 <1517850115-24340-3-git-send-email-daniel.baluta@nxp.com> <CAOMZO5D_5E9H6dJw8ivOgvOqxNvAZ72qhADCoG7VAZ7QwiOcUw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 6 Feb 2018 00:16:10 -0200
Message-ID: <CAOMZO5CowTer3Du86WZ+_v40H_iDWhDt8-x_uComy6wssH4tsA@mail.gmail.com>
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

On Mon, Feb 5, 2018 at 6:26 PM, Fabio Estevam <festevam@gmail.com> wrote:

>> +Example:
>> +
>> +&i2c {
>> +       ak5558: adc@10 {
>
> If I understood well Rob's suggestion was to make it only:
>
> adc@10 {

Ops, you did it correctly :-)

Thanks

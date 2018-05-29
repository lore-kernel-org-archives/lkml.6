Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935283AbeE2PXM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:23:12 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45366 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934789AbeE2PXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:09 -0400
X-Google-Smtp-Source: ADUXVKJ2LATsn7VjH12jFlX0K25Kb0igooucZqJGo42srXdgWvSTIn23H2Ywc6f5iyabq85uTuSz/Fo7T3kYath6dDE=
MIME-Version: 1.0
In-Reply-To: <20180529150455.17300-3-peron.clem@gmail.com>
References: <20180529150455.17300-1-peron.clem@gmail.com> <20180529150455.17300-3-peron.clem@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 May 2018 12:23:08 -0300
Message-ID: <CAOMZO5BVBbdEC5zoUmV=i3LZGgcipY2QCgv-aCd0teZ-MENd-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ARM: clk-imx6q: add EPIT clock support
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TFNH8x000948

On Tue, May 29, 2018 at 12:04 PM, Clément Péron <peron.clem@gmail.com> wrote:
> From: Colin Didier <colin.didier@devialet.com>
>
> Add EPIT clock support to the i.MX6Q clocking infrastructure.
>
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>

Subject could be improved to match the existing style:

clk: imx6: add EPIT clock support

Other than that:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

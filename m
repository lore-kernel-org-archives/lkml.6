Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeCTB5r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:57:47 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:40682 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbeCTB5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:57:42 -0400
X-Google-Smtp-Source: AG47ELs7EbEfJVKsRbba+TYMilRE6zB87Zk0pj2W/Ilbk5vQ2p9LtrjvEhAC0m5usXP/3fOreW2PL0nZAbtoQIHARxw=
MIME-Version: 1.0
In-Reply-To: <1521429281-23394-1-git-send-email-Anson.Huang@nxp.com>
References: <1521429281-23394-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Mar 2018 22:57:41 -0300
Message-ID: <CAOMZO5A0fA2h_T__vFzGXPzrzKZJuMyiRLRvNag43Xffif1EZQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-pinfunc: update sai select input value
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Mon, Mar 19, 2018 at 12:14 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Update SAI select input daisy chain value according to
> Reference Manual.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Could you please clarify the authorship of this patch? Is this yours
or from Shengjiu Wang?

If it is from Shengjiu Wang then his name should appear in the From
field and his Signed-off-by tag should appear first and yours should
go after it.

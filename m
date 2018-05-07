Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeEGOHs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:07:48 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:35002 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeEGOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:07:44 -0400
X-Google-Smtp-Source: AB8JxZqxPuxwZ7GSoOO2p6ueOApbKn4iZSYA/6lDSAqwRGRFnjRuxs8YcT0aI8twbdCz4Mf5izpqwoQNMUbTENVvSSw=
MIME-Version: 1.0
In-Reply-To: <20180425173932.7213-2-jagan@amarulasolutions.com>
References: <20180425173932.7213-1-jagan@amarulasolutions.com> <20180425173932.7213-2-jagan@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 7 May 2018 11:07:43 -0300
Message-ID: <CAOMZO5BpmBg2Xio21Sj=hBK_RLxQ_c19wRQDZRZ1ZZ9KtGzyWw@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: dts: i.MX6: imx6dl-mamoj: Add parallel display support
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Fabio maggi <fabio.mauri@bticino.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        Raffaele Recalcati <lamiaposta71@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 2:39 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> This patch adds parallel display support for i.MX6DL Mamoj board
> along with relevant backlight through pwm.
>
> LCD power sequence is added by 'Michael Trimarchi'.
>
> Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
> Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

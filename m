Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeCOR7w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:59:52 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34126 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeCOR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:59:50 -0400
X-Google-Smtp-Source: AG47ELv546D7sxzG1RpTsR3y9yWZwlSgDhDaT8D0wlvaN472nktgvPD417FD/7+646CaowlTKw5Af1vHzhSVqjsl8SM=
MIME-Version: 1.0
In-Reply-To: <20180315170710.9551-3-jagan@amarulasolutions.com>
References: <20180315170710.9551-1-jagan@amarulasolutions.com> <20180315170710.9551-3-jagan@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 15 Mar 2018 14:59:49 -0300
Message-ID: <CAOMZO5CVU9433zP3mgFQKwVjhRYhaM33RQ_DtavZd2xaxHQpkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6dl-mamoj: Add PFUZE100 support
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 2:07 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> MX6DL Mamoj boards has Freescale PFUZE100 PMIC, so add support for it.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
> Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>

This one could be probably part of the previous patch that adds the
initial board support.

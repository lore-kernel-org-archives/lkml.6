Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755976AbeDYRpl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:45:41 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:38699 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755295AbeDYRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:45:38 -0400
X-Google-Smtp-Source: AB8JxZrEJGD/+GD7YGRseJox9citwB+1qVUxVXhRfNQwhm45U4dRlMNh2U84ikCKDni43xjP2soXfiTka917yjeYgoo=
MIME-Version: 1.0
In-Reply-To: <20180425173932.7213-1-jagan@amarulasolutions.com>
References: <20180425173932.7213-1-jagan@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Apr 2018 14:45:36 -0300
Message-ID: <CAOMZO5AjwOhZYHC4sq41piZvvwNvART6cPUy2r1etVYLs4mRuA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/panel: simple: Add support for Rocktech
 RK070ER9427 LCD panel
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
        Fabio maggi <fabio.mauri@bticino.it>,
        Raffaele Recalcati <lamiaposta71@gmail.com>,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Wed, Apr 25, 2018 at 2:39 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> This adds support for the Rocktech Display Ltd. RK070ER9427
> 800(RGB)x480 TFT LCD panel, which can be supported by the
> simple panel driver.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

You missed to send this to the drm panel maintainers.

./scripts/get_maintainer.pl can help you.

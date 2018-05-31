Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932701AbeEaDHU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:07:20 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38353 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbeEaDHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:07:18 -0400
X-Google-Smtp-Source: ADUXVKJ08Tyvn3Q+/ZbpeGoPLR6kg8S49Wvh1l/xim1YweZDs/ziwcJXDdlgs5aGSsB6fkD/EDlP1Q==
Date: Wed, 30 May 2018 22:07:15 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?iso-8859-1?Q?Cl=E9ment?= Peron <clement.peron@devialet.com>
Subject: Re: [PATCH v4 2/5] clk: imx6: add EPIT clock support
Message-ID: <20180531030715.GA28712@rob-hp-laptop>
References: <20180530120327.27681-1-peron.clem@gmail.com>
 <20180530120327.27681-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180530120327.27681-3-peron.clem@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 02:03:24PM +0200, Clément Péron wrote:
> From: Colin Didier <colin.didier@devialet.com>
> 
> Add EPIT clock support to the i.MX6Q clocking infrastructure.
> 
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6q.c               | 2 ++
>  include/dt-bindings/clock/imx6qdl-clock.h | 4 +++-

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 5 insertions(+), 1 deletion(-)

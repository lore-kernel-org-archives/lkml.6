Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbeE3MeC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:34:02 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45243 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbeE3Md6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:33:58 -0400
X-Google-Smtp-Source: ADUXVKL6fEdPUQYl+/C8mKGoF9dQT1CJvgUM+esVyc7L1CCs3GzgOX5UkdBgeTynLgPC7jLd031/NSL7xe4BPwMFsgM=
MIME-Version: 1.0
In-Reply-To: <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com> <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 May 2018 09:33:57 -0300
Message-ID: <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle driver
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, May 30, 2018 at 4:12 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SLL supports ARM power off in cpu idle, better to reuse
> i.MX6SX cpu idle driver instead of i.MX6SL which does NOT
> support ARM power off.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/mach-imx/cpuidle-imx6sl.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
> index fa8ead1..8d866fb 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6sl.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
> @@ -12,7 +12,6 @@
>
>  #include "common.h"
>  #include "cpuidle.h"
> -#include "hardware.h"

The removal of this header file seems to be an unrelated change.

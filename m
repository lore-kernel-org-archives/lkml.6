Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeFCU5W (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 16:57:22 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33714 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeFCU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 16:57:20 -0400
X-Google-Smtp-Source: ADUXVKITQfMF49J9i0XlGWlofgZsEhvCInw+k+VTovB7tcJsaoNivye22c0G39nPKJWzpa6gs0CUqoYZsVGPD//jfeM=
MIME-Version: 1.0
In-Reply-To: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
References: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 3 Jun 2018 17:57:19 -0300
Message-ID: <CAOMZO5BiAHjrMQnwuOFR7XMcpQpi=WXO=Uh=mZO1vDLNoJdGzA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] ARM: imx: add L2 page power control for GPC
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
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

On Sat, Jun 2, 2018 at 11:33 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Some platforms like i.MX6UL/i.MX6SLL have L2
> page power control in GPC, it needs to be
> disabled if ARM is power gated and L2 is NOT
> flushed, add GPC interface to control it.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

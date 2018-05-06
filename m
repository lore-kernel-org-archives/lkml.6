Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEFPHY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 11:07:24 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:33352 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeEFPHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 11:07:19 -0400
X-Google-Smtp-Source: AB8JxZpB6ITvrp5+RaSYEWOAjuFimRdXDalYun4dG9EiYHAtMLirGVDzc6o926Ae9sMJDDFDqubnwu1Es8BSCX9pWjk=
MIME-Version: 1.0
In-Reply-To: <1525588093-29994-6-git-send-email-Anson.Huang@nxp.com>
References: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com> <1525588093-29994-6-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 6 May 2018 12:07:18 -0300
Message-ID: <CAOMZO5AzfxqGg4Pms0Z4S8Ktki7VZRD1U66zqMNzvr+D660Jsg@mail.gmail.com>
Subject: Re: [PATCH V7 6/7] ARM: dts: imx6sx-sabreauto: add debug LED support
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fugang Duan <fugang.duan@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
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

On Sun, May 6, 2018 at 3:28 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> There is a debug LED(D11) connected to GPIO1_IO24,
> add support for it.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeEFPHD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 11:07:03 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:40353 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeEFPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 11:07:00 -0400
X-Google-Smtp-Source: AB8JxZoUMd80MPOowiOrqorD/E7aiiCXAzBjnUM11EZf+H61xm3Z8npuovvg20AJxo42KbJ+EWpZ1+Wvj3wFPu4n2z0=
MIME-Version: 1.0
In-Reply-To: <1525588093-29994-5-git-send-email-Anson.Huang@nxp.com>
References: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com> <1525588093-29994-5-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 6 May 2018 12:06:59 -0300
Message-ID: <CAOMZO5AzcTkzbYpaXanugqWmKZmKmrO3nFd2QGyiqo5gOZ3vAw@mail.gmail.com>
Subject: Re: [PATCH V7 5/7] ARM: dts: imx6sx-sabreauto: add wdog external reset
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
> i.MX6SX Sabre Auto board has GPIO1_IO13 pin can be
> MUXed as WDOG output to reset PMIC, add this function
> support.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

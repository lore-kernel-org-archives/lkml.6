Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeFCU6P (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 16:58:15 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35167 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeFCU6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 16:58:14 -0400
X-Google-Smtp-Source: ADUXVKJgUub7TJocCMceuXQDyy3gv8JwHH12ZrzUBLUvV+RcH0ErybWMwRW3iyQm8sZYFC2fBvP7NGXJx7SqTg7n694=
MIME-Version: 1.0
In-Reply-To: <1527993226-19587-3-git-send-email-Anson.Huang@nxp.com>
References: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com> <1527993226-19587-3-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 3 Jun 2018 17:58:13 -0300
Message-ID: <CAOMZO5CjOyy-rohwfLS+TuWqTFVHExj=_R2_P-N7BTb_Kn5FuA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu
 idle driver
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
> i.MX6SLL supports ARM power off in cpu idle, better to reuse
> i.MX6SX cpu idle driver instead of i.MX6SL which does NOT
> support ARM power off.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

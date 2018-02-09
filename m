Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeBIUIr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 15:08:47 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35224 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBIUIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 15:08:45 -0500
X-Google-Smtp-Source: AH8x225QqameZCN/PyXnL12uXsl4ya1UlHDdZG62UK9qBpBgr0xjyW3wguD3AQe5jdYHH7yYnvguR4inzXK/Nb7kev4=
MIME-Version: 1.0
In-Reply-To: <20180209170358.7227-3-sebastian.reichel@collabora.co.uk>
References: <20180209170358.7227-1-sebastian.reichel@collabora.co.uk> <20180209170358.7227-3-sebastian.reichel@collabora.co.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 9 Feb 2018 18:08:44 -0200
Message-ID: <CAOMZO5AnTHn7VmD9dkOYwkW6eQNcdxC8tBOKNqhNGy5Oija2zA@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] ARM: dts: imx53: PPD: Enable secure-reg-access
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, kernel@collabora.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 3:03 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Add secure-reg-access on PPD device tree to enable PMU and
> hardware counters for perf.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

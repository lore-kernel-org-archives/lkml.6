Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934711AbeBLMsq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:48:46 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40880 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeBLMso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:48:44 -0500
X-Google-Smtp-Source: AH8x225sBAhgUE+yWcv86WYWcfXz+rVXzCgzjQnA4i2hm7DJDPIcnIjUvXeaOJJssZl4I8gnyyxq6EHyU5t9QB0hSGI=
MIME-Version: 1.0
In-Reply-To: <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk> <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 12 Feb 2018 10:48:43 -0200
Message-ID: <CAOMZO5A6OSe_i8L_9NXGR-FjFg1msGeybtj9Yk5FLKszZMe+SA@mail.gmail.com>
Subject: Re: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
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

On Mon, Feb 12, 2018 at 10:39 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> On i.MX53 it is necessary to set the DBG_EN bit in the
> platform GPC register to enable access to PMU counters
> other than the cycle counter.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

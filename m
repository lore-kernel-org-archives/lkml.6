Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeBAOyE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:54:04 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:41088 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeBAOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:54:01 -0500
X-Google-Smtp-Source: AH8x226ZNfjHz4Hz488cD2zcqm3fsAzKAXXF23v0nbqjRd2gECojKCSrgCiRiWWzBK9vOri8IApWpadBD4oNis6h3NM=
MIME-Version: 1.0
In-Reply-To: <1517364040-27607-5-git-send-email-pure.logic@nexus-software.ie>
References: <1517364040-27607-1-git-send-email-pure.logic@nexus-software.ie> <1517364040-27607-5-git-send-email-pure.logic@nexus-software.ie>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 1 Feb 2018 12:53:59 -0200
Message-ID: <CAOMZO5AncBkkA7azkZx2LWJ=O_dgmiHAYvV4iAgy5+VaTKijOQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] clk: imx7d: add CAAM clock
To: "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Cc: Horia Geanta Neag <horia.geanta@nxp.com>, aymen.sghaier@nxp.com,
        linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        lukas.auer@aisec.fraunhofer.de, rui.silva@linaro.org,
        Ryan Harkin <ryan.harkin@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11EsBEP027317

On Wed, Jan 31, 2018 at 12:00 AM, Bryan O'Donoghue
<pure.logic@nexus-software.ie> wrote:
> From: Rui Miguel Silva <rui.silva@linaro.org>
>
> Add CAAM clock so that we could use the Cryptographic Acceleration and
> Assurance Module (CAAM) hardware block.
>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk@vger.kernel.org
> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

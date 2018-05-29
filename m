Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935114AbeE2PV3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:21:29 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40566 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935029AbeE2PVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:21:25 -0400
X-Google-Smtp-Source: ADUXVKJDN4ysHOk/XxgSVPmMJPct4rwjhf1hWHq0tW+/xhp/OIOFtZlTAi6uJqLd3x9vdzxzoeM/0wzmO9CtEzwnZSM=
MIME-Version: 1.0
In-Reply-To: <20180529150455.17300-2-peron.clem@gmail.com>
References: <20180529150455.17300-1-peron.clem@gmail.com> <20180529150455.17300-2-peron.clem@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 May 2018 12:21:24 -0300
Message-ID: <CAOMZO5DRsYjmmzprs6rCqp76Y0xsnRE46r+_jxBvkFeMux8+xA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ARM: imx: remove inexistant EPIT timer init
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TFLWkD000932

On Tue, May 29, 2018 at 12:04 PM, Clément Péron <peron.clem@gmail.com> wrote:
> From: Clément Peron <clement.peron@devialet.com>
>
> i.MX EPIT timer has been removed but not the init function declaration.
>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

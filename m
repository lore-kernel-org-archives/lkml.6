Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeFELBv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:01:51 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37801 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeFELBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:01:48 -0400
X-Google-Smtp-Source: ADUXVKJNmC2wHllSfi1d3bdzVeUvG6Pw5HedJlqQHQYQ/lJPSax65oSG2RM8rs/AqaoPOpSlj96zqYfrcx0sX5CeLUM=
MIME-Version: 1.0
In-Reply-To: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Jun 2018 08:01:47 -0300
Message-ID: <CAOMZO5CsX-oiUXGicL1P61PcT67S9mhTTO5ibuXsQNd+UGt-Kg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?=
        <sebastien.szymanski@armadeus.com>
Cc: "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55B1sKF004148

On Tue, May 22, 2018 at 3:28 AM, Sébastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
> Check the max speed supported from the fuses for i.MX6ULL and update the
> operating points table accordingly.
>
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

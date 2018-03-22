Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755864AbeCVOEr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:04:47 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46718 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755848AbeCVOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:04:41 -0400
X-Google-Smtp-Source: AG47ELvLEsa+l6HEQG9j4vSD/DIOaduDEyB/jbyExBym6TBt0wPf61NuTgx+rTosla+7Ju5chhFckwqgC+Y+vjpAs5U=
MIME-Version: 1.0
In-Reply-To: <20180322132950.lkljwy2w7mobzgp2@fsr-ub1664-175>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com>
 <1521712529-632-3-git-send-email-abel.vesa@nxp.com> <CAOMZO5BVxp7pq44pUp444CqsYcJ5QQFqrgdRyFbaxRi0_d0ssg@mail.gmail.com>
 <20180322132950.lkljwy2w7mobzgp2@fsr-ub1664-175>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Mar 2018 11:04:40 -0300
Message-ID: <CAOMZO5BDBjB5muij_+QQ-9Q8Dzam=-0nP6gj6fHQHrJuv5=gNg@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm: imx: Correct dram pll type
To: Abel Vesa <abel.vesa@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Anson Huang <anson.huang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 10:29 AM, Abel Vesa <abel.vesa@nxp.com> wrote:

> Which repo/branch should this patchset be created against ?

You can use linux-next or Shawn's for-next tree.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeFCMyC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:54:02 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46802 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeFCMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:54:01 -0400
X-Google-Smtp-Source: ADUXVKJ464Re9vT9QABEWIcMHOetRA/cqqndZ4TODn4f3gTsMEgKG8/AKNXM9b0P+GXwJNyNgxZHyiTe4povKjns7QY=
MIME-Version: 1.0
In-Reply-To: <2D554312-36F2-4781-899C-8D9F5BD20B46@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CmgBsaaegVV9OjdyXv5_O0V9iTS2qYbtuH26qkG2_zrA@mail.gmail.com> <2D554312-36F2-4781-899C-8D9F5BD20B46@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 3 Jun 2018 09:54:00 -0300
Message-ID: <CAOMZO5ANz-B-s93+R_xnF0LOux1zTY3E8Ky4KvrZ8EX1ZKmpAQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx6q: remove clks_init_on array
To: Anson Huang <anson.huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Sun, Jun 3, 2018 at 9:48 AM, Anson Huang <anson.huang@nxp.com> wrote:

> As I explain in previous mail, busy divider clk type already include the flag when registered.

Ok, then please add this information in the commit log to make the
review process easier.

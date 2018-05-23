Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeEWJLc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:11:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51552 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754471AbeEWJL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:11:29 -0400
X-Google-Smtp-Source: AB8JxZpqzB6afBqGTzvqOUr5l+zvftS32qbv1/OXWkMIcHaJzyjaOY0mse30rpm3tA6Jtv9n/36l9ucUn3hNDj8rzXI=
MIME-Version: 1.0
In-Reply-To: <1526299191-1140-1-git-send-email-david.wu@rock-chips.com>
References: <1526299191-1140-1-git-send-email-david.wu@rock-chips.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 May 2018 11:11:27 +0200
Message-ID: <CACRpkdZ1J0O6QD_N9fr1HNHwXqe6Kg4rKMimUT7SDHYTzKqfRw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rockchip: Add pinctrl support for PX30
To: David Wu <david.wu@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Tao Huang <huangtao@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 1:59 PM, David Wu <david.wu@rock-chips.com> wrote:

> There are 4 banks (GPIO0 ~ GPIO3), bank0 is in PD_PMU
> subsystem, bank1/bank2/bank3 are in PD_BUS subsystem.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>

Patch applied with Heiko's review tag.

Yours,
Linus Walleij

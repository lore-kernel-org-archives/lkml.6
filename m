Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932325AbeENNgu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:36:50 -0400
Received: from gloria.sntech.de ([95.129.55.99]:45990 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753331AbeENNgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:36:48 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: David Wu <david.wu@rock-chips.com>
Cc: linus.walleij@linaro.org, huangtao@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: rockchip: Add pinctrl support for PX30
Date: Mon, 14 May 2018 15:36:37 +0200
Message-ID: <2756512.RvepBuBXky@phil>
In-Reply-To: <1526299191-1140-1-git-send-email-david.wu@rock-chips.com>
References: <1526299191-1140-1-git-send-email-david.wu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Am Montag, 14. Mai 2018, 13:59:51 CEST schrieb David Wu:
> There are 4 banks (GPIO0 ~ GPIO3), bank0 is in PD_PMU
> subsystem, bank1/bank2/bank3 are in PD_BUS subsystem.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

the PX30 looks pretty simple in the pinctrl-area and I couldn't
find anything looking out of the ordinary, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Thanks
Heiko

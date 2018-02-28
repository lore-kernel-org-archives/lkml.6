Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeB1L7U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:59:20 -0500
Received: from gloria.sntech.de ([95.129.55.99]:53002 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752192AbeB1L7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:59:19 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jeffy Chen <jeffy.chen@rock-chips.com>, wxt@rock-chips.com
Cc: linux-kernel@vger.kernel.org, tfiga@chromium.org,
        dmitry.torokhov@gmail.com, robin.murphy@arm.com,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] soc: rockchip: power-domain: remove PM clocks
Date: Wed, 28 Feb 2018 12:59:14 +0100
Message-ID: <4580848.piTrlVmp9H@diego>
In-Reply-To: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

Am Mittwoch, 28. Februar 2018, 12:11:13 CET schrieb Jeffy Chen:
> Currently we are adding all of the attached devices' clocks as pm clocks
> and enable them when powering on the power domain.
> 
> This seems unnecessary, because those clocks are already controlled in
> the devices' drivers with better error handling.
> 
> Tested on my chromebook minnie(rk3288) and chromebook kevin(rk3399).
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Looks ok to me and does not seem to interfere with the synchronous
reset that still stays intact.

@Ceasar: any objections?


Heiko

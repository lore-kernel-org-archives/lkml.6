Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeECMge (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:36:34 -0400
Received: from gloria.sntech.de ([95.129.55.99]:43640 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbeECMga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:36:30 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: use canonical compatible for touchpad/touchscreen
Date: Thu, 03 May 2018 14:36:13 +0200
Message-ID: <3507285.Efm3MEd05V@phil>
In-Reply-To: <20180501224628.GA150745@dtor-ws>
References: <20180501224628.GA150745@dtor-ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 2. Mai 2018, 00:46:28 CEST schrieb Dmitry Torokhov:
> "atmel,atmel_mxt_tp" and "atmel,atmel_mxt_ts" are ChromeOS inventions,
> let's replace them with canonical compatible string "atmel,maxtouch".
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I've amended the patch subject with a "on gru-kevin" and applied
it for 4.18 with Brian's Reviewed-by


Thanks
Heiko

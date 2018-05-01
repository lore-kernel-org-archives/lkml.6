Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756079AbeEAPUw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:20:52 -0400
Received: from muru.com ([72.249.23.125]:39450 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755316AbeEAPUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:20:50 -0400
Date: Tue, 1 May 2018 08:20:43 -0700
From: Tony Lindgren <tony@atomide.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        letux-kernel@openphoenux.org, linux-omap <linux-omap@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap3-gta04: Add fixed 26MHz clock as fck for
 twl
Message-ID: <20180501152042.GA98604@atomide.com>
References: <c0b35797744a71df9d8088508814675cc5f07710.1522944315.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b35797744a71df9d8088508814675cc5f07710.1522944315.git.hns@goldelico.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [180405 09:07]:
> The board uses 26MHz oscillator for the twl4030 HFCLK.
> This way we will not depend on the bootloader to configure the
> CFG_BOOT:HFCLK_FREQ
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applying into omap-for-v4.18/dt thanks.

Tony

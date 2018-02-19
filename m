Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBSItX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:49:23 -0500
Received: from gloria.sntech.de ([95.129.55.99]:46966 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752245AbeBSItV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:49:21 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou
Date: Mon, 19 Feb 2018 09:47:58 +0100
Message-ID: <1877328.7ff6v7Dvk9@phil>
In-Reply-To: <20180219081855.34400-1-klaus.goger@theobroma-systems.com>
References: <20180219081855.34400-1-klaus.goger@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 19. Februar 2018, 09:18:52 CET schrieb Klaus Goger:
> Enables the audio codec on the Haikou Baseboard when used with a RK3399-Q7.
> 
> Changes in v3:
> - split i2s0 move from rk3399-puma-haikou.dts to rk3399-puma.dtsi into it's
>   own patch
> - use dasheѕ in node names
> - added missing vin-supply properties to regulators
>   had to add an additional regulator to model this correctly
> - simple overwrite pins in i2s0_2ch_bus instead of deleting and redefining
>   the node

applied both patches for 4.17, only moved the oscillator node a bit
upwards in the file.


Thanks
Heiko

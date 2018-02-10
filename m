Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeBJBmS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:42:18 -0500
Received: from mout.perfora.net ([74.208.4.194]:42295 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbeBJBmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:42:15 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] ARM: dts: tegra: apalis/colibri updates
Date: Sat, 10 Feb 2018 02:36:35 +0100
Message-Id: <20180210013638.28164-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:UOURkEg1c4pvpUV6/BJRME8AdP8sp8+FnrAhbqT50glznRoJMAS
 gA2PUw6sVUbq8ZHIoHDWKdOuFc03dOUH8PVj/SXGaiX2JdSFTtFrONqsWVxY25F3klLaPzB
 9KdzQJhzEnV5vXOnS7+YHvyqeckfmHAISv6QvX5YCtBC2wxpVrCR2OYoMXz/rg0RDKauUd8
 I5lMB/hEE5slWOxs/T14A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lzmfJIzjThc=:gM4NvBpOYG7/afu88BWTrV
 gHhCLOIx89lE9gnjF/dUSyScwdf+/bFLztIlKYsC4slkaDpuXzxk6X+GQhjmD0PB9xYfNNyw+
 A+kIUgtZpopIqY2q5bxcrYbwWtCcCZelY6Wo3OpVlMN7OWeQIuayJWGp1Ot8gg+763g8hRlsX
 jhvYa7GqFXgfTnOE2+M63r6hJp0rFdqMND87llF7PJC05Pe/W/YkIjLmMoKWC+tMUt7hqqeRk
 EzerDr2NG/aZwO7fS0TGUplwED414+fF8of1H42FZRvAV38WMXSVqr/3An6SJOkaaaHB5WeR4
 2OeENHHgmUDqRGTe8Z1jnzKQgF9QFMkWOmxra7fB9Oq5N943/8YzzZtgxeh246AvQDGUn+dco
 SVfJOsZCaboNxsHTjPOEUBYEWxLzegLiFozf9kJxcH8blKZ7WXxzQn74EF1aBWisBTHhAujRv
 h3E4hGvesQTjUAd1sZqONybeNM20WbA5Lcdhaua3JL171ZPUjn3bMJ+KJo14GkRXn1oN4Nnvk
 DC24DpnwU6ErXFrI4heZp+v1aPfiq/iiBm3hSzyzpKZKDOmNrTe3ttzDPvUKK/zIfMIA/7Zcq
 sgIWudi4WLUXVAShnUIUTUekh/kui+aTQe9iRhpAjN9iOjWxJqVekZpT/Kle8Ei42rOxsiQjH
 UcFj4B6joL2lOdhComhJJqmiwZzcK++/gOiJ2cbNKY5mkQ4ogpaArlV4+7R07UTXfucZmPr62
 2tB3Yn+r/kNTLyOSX7geLT9zRpouq2/GPCkKaw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series fixes the I2C bus frequencies, uses the correct compatible
for the RTC and removes an unneeded reg property for Tegra based
Toradex Apalis and Colibri modules.


Marcel Ziswiler (3):
  apalis_t30/tk1, colibri_t20/t30: fix i2c bus frequencies
  ARM: dts: tegra: apalis/colibri: use correct compatible for rtc
  ARM: dts: tegra: apalis/colibri: remove unneeded reg property

 arch/arm/boot/dts/tegra124-apalis-eval.dts    |  7 +++----
 arch/arm/boot/dts/tegra124-apalis.dtsi        |  2 +-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi    | 16 +++++++++++-----
 arch/arm/boot/dts/tegra30-apalis-eval.dts     |  4 ++--
 arch/arm/boot/dts/tegra30-apalis.dtsi         |  3 +--
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  4 ++--
 arch/arm/boot/dts/tegra30-colibri.dtsi        |  3 +--
 7 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.14.3

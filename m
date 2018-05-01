Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756109AbeEAP11 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:27:27 -0400
Received: from muru.com ([72.249.23.125]:39486 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755872AbeEAP10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:27:26 -0400
Date: Tue, 1 May 2018 08:27:23 -0700
From: Tony Lindgren <tony@atomide.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        bcousson@baylibre.com, nsekhar@ti.com
Subject: Re: [PATCH] ARM: dts: am33xx: Add pinmux data for mmc1 in
 am335x-evm, evmsk and beaglebone
Message-ID: <20180501152723.GC98604@atomide.com>
References: <1523447304-21037-1-git-send-email-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523447304-21037-1-git-send-email-faiz_abbas@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180411 04:48]:
> am335x-evm, am335x-evmsk and am335x-beaglebone are currently relying on
> pinmux set by the bootloader to set the correct value for mmc1. Fix
> this by adding pinmux data for the same in kernel.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applying into omap-for-v4.18/dt thanks.

Tony

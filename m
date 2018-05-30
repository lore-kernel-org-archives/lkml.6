Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753660AbeE3P2b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:28:31 -0400
Received: from muru.com ([72.249.23.125]:45262 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbeE3P23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:28:29 -0400
Date: Wed, 30 May 2018 08:28:25 -0700
From: Tony Lindgren <tony@atomide.com>
To: Tero Kristo <t-kristo@ti.com>
Cc: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, bcousson@baylibre.com, paul@pwsan.com
Subject: Re: [PATCH v2 1/6] ARM: dra762: hwmod: Add MCAN support
Message-ID: <20180530152825.GG5705@atomide.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-2-faiz_abbas@ti.com>
 <20180530145047.GC5705@atomide.com>
 <cfa9c9df-57a2-69f6-9509-440dc18292e7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfa9c9df-57a2-69f6-9509-440dc18292e7@ti.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [180530 15:18]:
> For the OCP if part, I think that is still needed until we switch over to
> full sysc driver. clkctrl_offs you probably also need because that is used
> for mapping the omap_hwmod against a specific clkctrl clock. Those can be
> only removed once we are done with hwmod (or figure out some other way to
> assign the clkctrl clock to a hwmod.)

Hmm might be worth testing. I thought your commit 70f05be32133
("ARM: OMAP2+: hwmod: populate clkctrl clocks for hwmods if available")
already parses the clkctrl from dts?

Regards,

Tony

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033850AbeCASOv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:14:51 -0500
Received: from muru.com ([72.249.23.125]:59084 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033321AbeCASOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:14:50 -0500
Date: Thu, 1 Mar 2018 10:14:47 -0800
From: Tony Lindgren <tony@atomide.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        Nishant Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Message-ID: <20180301181447.GG62820@atomide.com>
References: <20180116011159.1386-1-tony@atomide.com>
 <1516095054.9022.1.camel@pengutronix.de>
 <20180116150314.GC4042@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116150314.GC4042@atomide.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180116 07:03]:
> * Philipp Zabel <p.zabel@pengutronix.de> [180116 09:52]:
> > Looks good to me. Can I move the compatible property when applying?
> 
> Oops, here's a better version. I also left out the "prcm" part as
> at some point that should have just ranges instead of both reg and
> ranges that it currently has.

Philipp, do you need me to resend v2 of this patch against v4.16-rc?

The changes we discussed with Suman can then be done as
separate patches as needed :)

Regards,

Tony

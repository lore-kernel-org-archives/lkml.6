Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161195AbeBNRZC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:25:02 -0500
Received: from muru.com ([72.249.23.125]:57090 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033363AbeBNRZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:25:00 -0500
Date: Wed, 14 Feb 2018 09:24:56 -0800
From: Tony Lindgren <tony@atomide.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/16] mmc: sdhci-omap: Add support to override f_max
 and iodelay from pdata
Message-ID: <20180214172455.GO6364@atomide.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-9-kishon@ti.com>
 <CAPDyKFrhpry40TCjmQ_-WO-EWa2BCL0eNXLZB_UobGaYbsBiHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrhpry40TCjmQ_-WO-EWa2BCL0eNXLZB_UobGaYbsBiHA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [180214 09:53]:
> On 5 February 2018 at 13:50, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > DRA74x EVM Rev H EVM comes with revision 2.0 silicon. However, earlier
> > versions of EVM can come with either revision 1.1 or revision 1.0 of
> > silicon.
> >
> > The device-tree file is written to support rev 2.0 of silicon.
> > pdata-quirks are used to then override the settings needed for
> > PG 1.1 silicon.
> >
> > PG 1.1 silicon has limitations w.r.t frequencies at which MMC1/2/3
> > can operate as well as different IOdelay numbers.
> 
> I fail to understand the need for platform data. Why can't DT be used
> for the older revisions as well?

Maybe the silicon revision is not available via soc_device_match()?

Regards,

Tony

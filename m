Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeEBOz7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:55:59 -0400
Received: from muru.com ([72.249.23.125]:39752 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbeEBOzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:55:54 -0400
Date: Wed, 2 May 2018 07:55:51 -0700
From: Tony Lindgren <tony@atomide.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v5 00/14] mmc: sdhci-omap: Add UHS/HS200 mode support
Message-ID: <20180502145551.GL98604@atomide.com>
References: <20180427114723.2687-1-kishon@ti.com>
 <CAPDyKFqb=Dyi=UMZBLKcrBbmaWbGEjf-Vp5vQ0b7_F__+YnXHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqb=Dyi=UMZBLKcrBbmaWbGEjf-Vp5vQ0b7_F__+YnXHQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [180502 13:17]:
> On 27 April 2018 at 13:47, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > Add UHS/HS200 mode support in sdhci-omap. The programming sequence
> > for voltage switching, tuning is followed from AM572x TRM
> > http://www.ti.com/lit/ug/spruhz6j/spruhz6j.pdf
> > (Similar to all AM57x/DRA7x SoCs). The patch series also implements
> > workaround for errata published in
> > http://www.ti.com/lit/er/sprz429l/sprz429l.pdf
> >
> > patches are created on top of
> > git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
> >
> > The patches along with dt has also been pushed to
> > https://github.com/kishon/linux-wip.git sdhci_uhs_v5
> 
> Thanks, applied for next!

OK. Ulf, can I use some commit id from your next as a base for
the related dts changes?

Regards,

Tony

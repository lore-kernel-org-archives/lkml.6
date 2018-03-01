Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965783AbeCADtv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 22:49:51 -0500
Received: from muru.com ([72.249.23.125]:58968 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965663AbeCADtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 22:49:49 -0500
Date: Wed, 28 Feb 2018 19:49:47 -0800
From: Tony Lindgren <tony@atomide.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 11/12] PM / AVS: SmartReflex: Prepare to use device tree
 based probing
Message-ID: <20180301034947.GE62820@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
 <20180223210100.86732-12-tony@atomide.com>
 <7hr2p41ok8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7hr2p41ok8.fsf@baylibre.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kevin Hilman <khilman@baylibre.com> [180301 03:08]:
> Tony Lindgren <tony@atomide.com> writes:
> > We are currently probing smartreflex with omap_device while we are
> > already probing smartreflex related interconnect target module with
> > ti-sysc driver and dts data.
...

> Acked-by: Kevin Hilman <khilman@baylibre.com>
> 
> I don't have anything else queued for this driver, so feel free to take
> it along with the rest of the series.

Thanks for looking, will do.

Tony

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeBZVeQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:34:16 -0500
Received: from muru.com ([72.249.23.125]:58366 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbeBZVeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:34:13 -0500
Date: Mon, 26 Feb 2018 13:34:11 -0800
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 11/12] PM / AVS: SmartReflex: Prepare to use device tree
 based probing
Message-ID: <20180226213411.GD16043@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
 <20180223210100.86732-12-tony@atomide.com>
 <5d37e6ff-9b89-b677-859e-6eeae5527276@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d37e6ff-9b89-b677-859e-6eeae5527276@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rafael J. Wysocki <rafael.j.wysocki@intel.com> [180226 10:38]:
> On 2/23/2018 10:00 PM, Tony Lindgren wrote:
> > We are currently probing smartreflex with omap_device while we are
> > already probing smartreflex related interconnect target module with
> > ti-sysc driver and dts data.
...
> You need an ACK from Kevin Hilman on this anyway and if you receive one,
> please feel free to route it whatever way is convenient for you.

Oops sorry about that Kevin. I did the Cc list from memory and
totally forgot about the MAINTAINERS entry for AVS drivers. I'll
also bounce the original email to Kevin for easier reading.

Regards,

Tony

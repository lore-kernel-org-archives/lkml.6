Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeB0RjK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:39:10 -0500
Received: from muru.com ([72.249.23.125]:58506 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751463AbeB0RjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:39:09 -0500
Date: Tue, 27 Feb 2018 09:39:06 -0800
From: Tony Lindgren <tony@atomide.com>
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc: Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy J <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v5 0/4] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume
 support
Message-ID: <20180227173906.GC5448@atomide.com>
References: <20180223154357.23504-1-d-gerlach@ti.com>
 <a56830af-cf81-3603-ba58-2a2c65c49f34@oracle.com>
 <20180226212650.GB16043@atomide.com>
 <58006020-85d9-9681-f80a-2f9eda1e863a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58006020-85d9-9681-f80a-2f9eda1e863a@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* santosh.shilimkar@oracle.com <santosh.shilimkar@oracle.com> [180227 00:19]:
> On 2/26/18 1:26 PM, Tony Lindgren wrote:
> > * Santosh Shilimkar <santosh.shilimkar@oracle.com> [180225 23:36]:
> > > > Dave Gerlach (4):
> > > >     ARM: OMAP2+: Introduce low-level suspend code for AM33XX
> > > >     ARM: OMAP2+: Introduce low-level suspend code for AM43XX
> > > >     ARM: OMAP2+: pm33xx-core: Add platform code needed for PM
> > > >     soc: ti: Add pm33xx driver for basic suspend support
> > > > 
> > > Are you going to pickup this series ?
> > 
> > Yes planning to apply it today or tomorrow.
> > 
> Sounds good.
> 
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Applied and pushed out into omap-for-v4.17/ampm.

Thanks,

Tony

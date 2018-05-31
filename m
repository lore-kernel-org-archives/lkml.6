Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755244AbeEaNuI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:50:08 -0400
Received: from muru.com ([72.249.23.125]:45432 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755175AbeEaNuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:50:03 -0400
Date: Thu, 31 May 2018 06:50:00 -0700
From: Tony Lindgren <tony@atomide.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, t-kristo@ti.com
Subject: Re: [PATCH v2 4/6] bus: ti-sysc: Add support for using ti-sysc for
 MCAN on dra76x
Message-ID: <20180531135000.GL5705@atomide.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-5-faiz_abbas@ti.com>
 <20180530145726.GD5705@atomide.com>
 <0b627ab6-59f1-4a4f-42d2-5d6846adfe0b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b627ab6-59f1-4a4f-42d2-5d6846adfe0b@ti.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180531 10:17]:
> Hi,
> 
> On Wednesday 30 May 2018 08:27 PM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [180530 14:12]:
> >> The dra76x MCAN generic interconnect module has a its own
> >> format for the bits in the control registers.
> ...
> >>  static int sysc_init_pdata(struct sysc *ddata)
> >>  {
> >>  	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
> >> @@ -1441,6 +1457,7 @@ static const struct of_device_id sysc_match[] = {
> >>  	{ .compatible = "ti,sysc-mcasp", .data = &sysc_omap4_mcasp, },
> >>  	{ .compatible = "ti,sysc-usb-host-fs",
> >>  	  .data = &sysc_omap4_usb_host_fs, },
> >> +	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
> >>  	{  },
> >>  };
> > 
> > Looks good to me. And presumably you checked that no other dra7 modules
> > use sysconfig register bit layout like this?
> > 
> 
> As far as I could see, Yes.

OK thanks for checking it.

Regards,

Tony

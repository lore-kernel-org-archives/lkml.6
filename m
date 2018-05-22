Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeEVOhU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:37:20 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:43941 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVOhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:37:18 -0400
X-Google-Smtp-Source: AB8JxZq2HuON/gi78D+deFyBNJy7f0s4gByWtNOB0yPleRmaQX+0lesUgnFWOBeWVNPokdIxiwomyg==
Date: Tue, 22 May 2018 07:37:15 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: "Y.b. Lu" <yangbo.lu@nxp.com>
Cc: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PTP clock driver for FSL DPAA
Message-ID: <20180522143715.7um4fot2zfowkbm2@localhost>
References: <DB6PR0401MB2536003AE2494FFE5AB7516FF8940@DB6PR0401MB2536.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0401MB2536003AE2494FFE5AB7516FF8940@DB6PR0401MB2536.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 10:07:20AM +0000, Y.b. Lu wrote:
> I'm going to make a PTP clock driver patch for FSL DPAA ethernet controller. (drivers/net/ethernet/freescale/dpaa/)
> Actually the 1588 timer module on FSL DPAA is same with the one on FSL eTSEC in hardware.(whose PTP clock driver is drivers/net/ethernet/freescale/gianfar_ptp.c)
> 
> So there are two options for me I think.
> Option #1, just make a dpaa_ptp.c driver which will be almost same with gianfar_ptp.c.
> Option #2, try to reuse gianfar_ptp.c driver by reworking it as a common driver, renaming it, and putting it to a common place (drivers/ptp/ or still drivers/net/ethernet/freescale/).

If you can make it work, #2 sounds like the best solution.

Thanks,
Richard

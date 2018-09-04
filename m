Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07C8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCD220645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCD220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIDTmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:42:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44551 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbeIDTmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:42:37 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 59D3E208AF; Tue,  4 Sep 2018 17:17:04 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3004C204AE;
        Tue,  4 Sep 2018 17:16:54 +0200 (CEST)
Date:   Tue, 4 Sep 2018 17:16:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     David Miller <davem@davemloft.net>
Cc:     andrew@lunn.ch, quentin.schulz@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 00/11] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180904151653.GI13888@piout.net>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
 <20180903133415.GF4445@lunn.ch>
 <20180903134522.GC13888@piout.net>
 <20180903.220910.899357653888940454.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903.220910.899357653888940454.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 22:09:10-0700, David Miller wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Date: Mon, 3 Sep 2018 15:45:22 +0200
> 
> > On 03/09/2018 15:34:15+0200, Andrew Lunn wrote:
> >> > I suggest patches 1 and 8 go through MIPS tree, 2 to 5 and 11 go through
> >> > net while the others (6, 7, 9 and 10) go through the generic PHY subsystem.
> >> 
> >> Hi Quentin
> >> 
> >> Are you expecting merge conflicts? If not, it might be simpler to gets
> >> ACKs from each maintainer, and then merge it though one tree.
> >> 
> > 
> > There are some other DT changes for this cycle so those should probably
> > go through MIPS.
> 
> No objection for this going through the MIPS tree, and from me:
> 

What I meant was that 1/11 and 8/11 should go through MIPS because of
the potential conflicts. The other patches can go through net-next as
that will make more sense. Maybe Quentin can split the series in two,
one for MIPS and one for net if that makes it easier for you to apply.

> Acked-by: David S. Miller <davem@davemloft.net>

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

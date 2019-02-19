Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FED2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfBSR44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:56:56 -0500
Received: from muru.com ([72.249.23.125]:39692 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfBSR44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:56:56 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2526580B6;
        Tue, 19 Feb 2019 17:57:05 +0000 (UTC)
Date:   Tue, 19 Feb 2019 09:56:51 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        jason@lakedaemon.net, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        marc.zyngier@arm.com, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190219175651.GN15711@atomide.com>
References: <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
 <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
 <20190218143245.GC15711@atomide.com>
 <84b3ec21-9ce9-b9a8-80a9-75001db43a90@ti.com>
 <20190219153537.GJ15711@atomide.com>
 <6aa37276-0833-fdf5-575b-c3ca14f776a6@ti.com>
 <20190219171104.GM15711@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219171104.GM15711@atomide.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190219 17:11]:
> * Lokesh Vutla <lokeshvutla@ti.com> [190219 16:19]:
> > yes. How different is this from any of the above mentioned drivers using
> > firmware specific ids. Like sci pm domain[1] driver utilizes the same
> > device id for enabling any device in the system. Similarly clock
> > driver[2] uses the same device ids and clock ids specified by firmware.
> > There are more which similarly represents firmware ids from DT.
> > 
> > [1] Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> > [2] Documentation/devicetree/bindings/clock/ti,sci-clk.txt
> 
> That's horrible. We really must not use any firmware invented
> numbers in the device as they do not describe hardware.

No firmware invented numbers in the device tree I mean naturally.
Drivers do whatever they need to do to deal with the firmware.

Regards,

Tony

Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD4EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50E820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfBDQgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:36:42 -0500
Received: from muru.com ([72.249.23.125]:37500 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbfBDQgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:36:42 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4D5BC808C;
        Mon,  4 Feb 2019 16:36:49 +0000 (UTC)
Date:   Mon, 4 Feb 2019 08:36:37 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com,
        nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com,
        woods.technical@gmail.com, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 03/14] dt-binding: irqchip: Add pruss-intc-irq driver
 for PRUSS interrupts
Message-ID: <20190204163637.GK5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-4-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549290167-876-4-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190204 14:23]:
> From: "Andrew F. Davis" <afd@ti.com>
> 
> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
> interrupt controller (INTC) that can handle various system input
> events and post interrupts back to the device-level initiators.
> The INTC can support upto 64 input events with individual control
> configuration and hardware prioritization. These events are mapped
> onto 10 interrupt signals through two levels of many-to-one mapping
> support. Different interrupt signals are routed to the individual
> PRU cores or to the host CPU.
> 
> The PRUSS INTC platform driver manages this PRUSS interrupt
> controller and implements an irqchip driver to provide a Linux
> standard way for the PRU client users to enable/disable/ack/
> re-trigger a PRUSS system event. The system events to interrupt
> channels and host interrupts relies on the mapping configuration
> provided through a firmware resource table for now. This will be
> revisited and enhanced in the future for a better interface. The
> mappings will currently be programmed during the boot/shutdown
> of the PRU.

Acked-by: Tony Lindgren <tony@atomide.com>

Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DD0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883392084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883392084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeGRTgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:36:32 -0400
Received: from muru.com ([72.249.23.125]:51960 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbeGRTgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:36:32 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A1F958087;
        Wed, 18 Jul 2018 19:00:29 +0000 (UTC)
Date:   Wed, 18 Jul 2018 11:57:15 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>, arm@kernel.org
Subject: Re: [PATCH V2 0/5] arm64: Initial support Texas Instrument's AM654
 Platform
Message-ID: <20180718185715.GG99251@atomide.com>
References: <20180626162615.19194-1-nm@ti.com>
 <20180718180455.gaej4fgf47zytdxk@kahuna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718180455.gaej4fgf47zytdxk@kahuna>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [180718 18:08]:
> On 16:26-20180626, Nishanth Menon wrote:
> > Hi,
> > 
> > This is an minor update from V1 posted earlier:
> > 	https://marc.info/?l=linux-kernel&m=152943745424138&w=2
> > 
> > The following series enables support for newest addition in TI's SoC
> > portfolio - AM654 SoC.
> > 
> > The series is based off v4.18-rc1, also available here:
> > https://github.com/nmenon/linux-2.6-playground/tree/upstream/v4.18-rc1/k3-1-am6-base
> > 
> > Key changes since RFC are indicated in respective patches:
> > * Pickedup Tony's Reviewed by
> > * Modified cbass nodes to indicate interconnect (patch #3 in the series)
> 
> Hi Tony,
> 
> Apologies on the off-request. Looks like Tero might be on vacation
> and might not be able to send the Pull request to arm-soc folks on time.
> 
> Requesting you to pick them up on our behalf for v4.19 if it that is
> fine with you. We do have Rob's ack on the bindings themselves, and
> the patches also have been reviewed as well.

Sure applying the whole series into am654-for-v4.19 branch.

Regards,

Tony

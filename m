Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7602C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAC720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAC720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeIGVmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:42:02 -0400
Received: from muru.com ([72.249.23.125]:55478 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeIGVmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:42:02 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D626D80CF;
        Fri,  7 Sep 2018 17:04:14 +0000 (UTC)
Date:   Fri, 7 Sep 2018 10:00:09 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] pci-dra7xx: Enable errata i870 workaround for RC
 mode
Message-ID: <20180907170009.GJ5662@atomide.com>
References: <20180724173150.2701-1-vigneshr@ti.com>
 <20180808165700.GB486@e107981-ln.cambridge.arm.com>
 <ba428a15-77bf-e09c-3bd7-b5a0eae7ee13@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba428a15-77bf-e09c-3bd7-b5a0eae7ee13@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [180810 10:10]:
> 
> 
> On Wednesday 08 August 2018 10:27 PM, Lorenzo Pieralisi wrote:
> > On Tue, Jul 24, 2018 at 11:01:46PM +0530, Vignesh R wrote:
> >> Make workaround for errata i870 applicable in Host mode as
> >> well(previously it was enabled only for EP mode) as per errata
> >> documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
> >>
> >> Tested on DRA72 EVM
> >>
> >> Tony,
> >>
> >> If you are okay with the series, could you pick this via omap tree?
> >> All ACKs are in place and Lorenzo is okay with PCIe bits to go along with
> >> rest of DTS changes.
> > 
> > I think we have missed the v4.19 merge window by now - 
> 
> Right. I didn't get any response from Tony.

Sorry catching up with pending mails.. I try hard to not touch
anything except fixes around -rc6 time.

> > please let me know if I can drop this series from the PCI patch queue.
> > 
> 
> Ok, I will resend the patch after 4.19-rc. Thanks!

FYI, I'm untagging this thread too. Please post the dts
changes separately once the dependencies (if any) have
cleared.

Regards,

Tony

Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BEAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBC724E28
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBC724E28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753911AbeGCGnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:43:46 -0400
Received: from muru.com ([72.249.23.125]:49714 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752232AbeGCGno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:43:44 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6AD4B8047;
        Tue,  3 Jul 2018 06:46:39 +0000 (UTC)
Date:   Mon, 2 Jul 2018 23:43:40 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arm@kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] arm: dts: dra74x: Add missing cooling device
 properties for CPUs
Message-ID: <20180703064340.GD112168@atomide.com>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <4860aab6e550b91ecc5c37c80cbffa6a6a70a4c9.1527244201.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4860aab6e550b91ecc5c37c80cbffa6a6a70a4c9.1527244201.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Viresh Kumar <viresh.kumar@linaro.org> [180525 03:35]:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.
> 
> Fix other missing properties (clocks, supply, clock latency) as well to
> make it all work.

Applying this one into omap-for-v4.19/dt thanks.

Regards,

Tony

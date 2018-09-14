Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27CAECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA3E20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA3E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeINP6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:58:11 -0400
Received: from foss.arm.com ([217.140.101.70]:59802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbeINP6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:58:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 025B780D;
        Fri, 14 Sep 2018 03:44:16 -0700 (PDT)
Received: from e107155-lin (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68B7B3F557;
        Fri, 14 Sep 2018 03:44:14 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:44:06 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Multi-parent IRQ domains
Message-ID: <20180914104406.GA28182@e107155-lin>
References: <20180913155945.GA19903@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913155945.GA19903@ulmo>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 05:59:45PM +0200, Thierry Reding wrote:
> Hi everyone,
>
> I've been trying to implement a feature on recent Tegra chips that's
> called "wake events".

By recent, is it same to assume PSCI based system ? And the GIC is power
managed by PSCI ?

--
Regards,
Sudeep

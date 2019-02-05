Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C68C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4A020821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfBEJZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:25:18 -0500
Received: from foss.arm.com ([217.140.101.70]:38542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfBEJZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:25:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EC01EBD;
        Tue,  5 Feb 2019 01:25:15 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03D6F3F71E;
        Tue,  5 Feb 2019 01:25:13 -0800 (PST)
Date:   Tue, 5 Feb 2019 09:25:07 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        peterz@infradead.org, tglx@linutronix.de, bigeasy@linutronix.de
Subject: Re: [PATCH 0/5] Fix Arm system PMU hotplug issues
Message-ID: <20190205092507.GA50400@lakrids.cambridge.arm.com>
References: <cover.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549299188.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:09:03PM +0000, Robin Murphy wrote:
> Hi all,
> 
> Following the report of a preemption-related bug in arm-cci, it turns
> out there's a fair bit of cleaning up to do in this area. I've started
> here with the Arm drivers that I'm fairly familiar with - I suspect the
> hisi/qcom/xgene ones suffer from similar issues, but it's going to take
> me a while longer to figure them out in detail.
> 
> Robin.

These all looks sound to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

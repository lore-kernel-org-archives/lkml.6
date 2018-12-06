Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A79AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8A120838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8A120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbeLFMeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:34:01 -0500
Received: from foss.arm.com ([217.140.101.70]:49520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbeLFMeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:34:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBF78A78;
        Thu,  6 Dec 2018 04:33:59 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA6D43F575;
        Thu,  6 Dec 2018 04:33:59 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C9B881AE0BAD; Thu,  6 Dec 2018 12:34:20 +0000 (GMT)
Date:   Thu, 6 Dec 2018 12:34:20 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: Re: [PATCH v11 0/2] Add ThunderX2 SoC Performance Monitoring Unit
 driver
Message-ID: <20181206123420.GA26473@arm.com>
References: <20181206115053.7665-1-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206115053.7665-1-ganapatrao.kulkarni@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ganapat,

On Thu, Dec 06, 2018 at 11:51:24AM +0000, Kulkarni, Ganapatrao wrote:
> This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
> The SoC has PMU support in L3 cache controller (L3C) and in the
> DDR4 Memory Controller (DMC).
> 
> 
> v11:
> 	Updated Patch 2 with minor comments.

Thanks. I've pushed this out on my perf/updates branch:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=perf/updates

but note that I did make some spelling and formatting changes to the
Documentation patch, as well as removal of the event descriptions (they
should be part of the perf tool, as is done for the other system PMUs).

Will

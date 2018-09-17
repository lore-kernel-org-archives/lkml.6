Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A5ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DEF214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DEF214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeIQTCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:02:12 -0400
Received: from foss.arm.com ([217.140.101.70]:59226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbeIQTCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:02:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E09BED1;
        Mon, 17 Sep 2018 06:34:50 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E9453F557;
        Mon, 17 Sep 2018 06:34:50 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id AAFB81AE3063; Mon, 17 Sep 2018 14:35:08 +0100 (BST)
Date:   Mon, 17 Sep 2018 14:35:08 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robert.richter@cavium.com,
        cwu@amperecomputing.com
Subject: Re: [PATCH RESEND 0/6] arm64: add support for generic cpu
 vulnerabilities
Message-ID: <20180917133508.GE23040@arm.com>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180905092533.GB17376@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905092533.GB17376@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:25:33AM +0200, Mian Yousaf Kaukab wrote:
> On Mon, Aug 27, 2018 at 04:33:04PM +0200, Mian Yousaf Kaukab wrote:
> > GENERIC_CPU_VULNERABILITIES provide a common way to figure out if a
> > system is affected by vulnerabilities like meltdown and other variants
> > of spectre. This small series adds support for it in arm64.
> 
> Marc, Will, Can you please review this series?

Sorry it took so long to get to this, it's just consistently failed to
get to the top of my review queue. I had a quick look just now and there
are a few things to address before we can take the series.

Cheers,

Will

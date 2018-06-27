Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C27C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDAF25F09
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDAF25F09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeF0J3I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:29:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:56983 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbeF0J3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:29:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFC69ADE9;
        Wed, 27 Jun 2018 09:29:05 +0000 (UTC)
Date:   Wed, 27 Jun 2018 11:29:05 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org
Subject: Re: [PATCH 0/3] iommu/amd: Enable x2APIC support
Message-ID: <20180627092905.7lgcp3iu5ijzslcw@suse.de>
References: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Suravee,

On Fri, Jun 22, 2018 at 12:02:04PM -0500, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (3):
>   x86: irq_remapping: Move irq remapping mode enum
>   iommu/amd: Add support for higher 64-bit IOMMU Control Register
>   iommu/amd: Add support for IOMMU XT mode

The patches look good to me, please include the fix for the kbuild-bot
report and re-send.


Thanks,

	Joerg


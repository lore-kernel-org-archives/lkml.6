Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9732EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549BB2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549BB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbeKPCDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:03:49 -0500
Received: from 8bytes.org ([81.169.241.247]:44832 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeKPCDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:03:48 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E0AC04A7; Thu, 15 Nov 2018 16:55:23 +0100 (CET)
Date:   Thu, 15 Nov 2018 16:55:22 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de
Subject: Re: [PATCH 7/7] vfio/type1: Remove map_try_harder() code path
Message-ID: <20181115155522.ukxnskxiqcoqxw3d@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
 <20181109110712.12469-8-joro@8bytes.org>
 <20181109092329.79b0fe91@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109092329.79b0fe91@t450s.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, Nov 09, 2018 at 09:23:29AM -0700, Alex Williamson wrote:
> Cool, glad to see this finally fixed.  My "should be fixed soon"
> comment turned out to be a little optimistic with the fix finally
> coming 5 years later.  We could of course keep this code as it really
> doesn't harm anything, but I'm in favor trying to remove it if we think
> it's dead now.

Yeah, it took a while to fix that :) And we can easily revert this patch
if it turns out someone else is also relying on the workaround.

> In order to expedite into one pull:
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Thanks a lot. I've queued these patches into my tree now.


Regards,

	Joerg

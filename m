Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3BEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37150214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37150214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLFPj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:39:29 -0500
Received: from 8bytes.org ([81.169.241.247]:52166 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeLFPj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:39:28 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 76A7F209; Thu,  6 Dec 2018 16:39:27 +0100 (CET)
Date:   Thu, 6 Dec 2018 16:39:27 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/5] driver core: Introduce device_iommu_mapped() function
Message-ID: <20181206153927.GI16835@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
 <20181204172504.19708-2-joro@8bytes.org>
 <20181206125520.GA28736@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206125520.GA28736@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 01:55:20PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 04, 2018 at 06:25:00PM +0100, Joerg Roedel wrote:
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > ---
> >  include/linux/device.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks a lot, Greg. Added your Acked-by to the patch.


Regards,

	Joerg

Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DB6C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB08F2089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB08F2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeKHTFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:05:08 -0500
Received: from 8bytes.org ([81.169.241.247]:60348 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbeKHTFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:05:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E70DE426; Thu,  8 Nov 2018 10:30:30 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:30:30 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: linux-next: build warning after merge of the iommu tree
Message-ID: <20181108093030.GD19831@8bytes.org>
References: <20181108123938.2026559e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108123938.2026559e@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Nov 08, 2018 at 12:39:38PM +1100, Stephen Rothwell wrote:
> Introduced by commit
> 
>   248808a0fad0 ("iommu/vt-d: Respect max guest address width in agaw")

Thanks for the report! That commit was revoked by the submitter and is
now removed from the tree. The warning should disappear in the next
merge.

Regards,

	Joerg

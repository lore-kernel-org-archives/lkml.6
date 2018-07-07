Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B547CC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6980221E20
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6980221E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932839AbeGGDWs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:22:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:32336 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932713AbeGGDWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:22:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 20:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,319,1526367600"; 
   d="scan'208";a="53223827"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2018 20:22:37 -0700
Subject: Re: [PATCH v3 0/9] iommu/vt-d: Improve PASID id and table management
To:     Joerg Roedel <joro@8bytes.org>
References: <1529385449-25649-1-git-send-email-baolu.lu@linux.intel.com>
 <20180706123155.oyubygktu3q3banv@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B4031FA.6000706@linux.intel.com>
Date:   Sat, 7 Jul 2018 11:22:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180706123155.oyubygktu3q3banv@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 07/06/2018 08:31 PM, Joerg Roedel wrote:
> Hey Lu,
>
> the patches do not apply cleanly to my x86/vt-d branch. Can you rebase
> against that branch after the weekend when I pushed it out and re-send,
> please?

Sure.

Best regards,
Lu Baolu

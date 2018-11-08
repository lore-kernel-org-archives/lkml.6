Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEC9C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7D420825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7D420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeKHTBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:01:39 -0500
Received: from 8bytes.org ([81.169.241.247]:60176 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbeKHTBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:01:39 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7A1D8426; Thu,  8 Nov 2018 10:27:02 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:27:02 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: respect max guest address width in agaw
Message-ID: <20181108092702.GC19831@8bytes.org>
References: <1541544435-52624-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20181107160428.awgpvo73mp3lbdro@8bytes.org>
 <20181107141225.2339ca4f@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107141225.2339ca4f@jacob-builder>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 02:12:25PM -0800, Jacob Pan wrote:
> We have found some issues with this patch on some platforms. Please
> disregard this patch.

Patch dropped.

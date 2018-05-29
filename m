Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933513AbeE2L4K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:56:10 -0400
Received: from 8bytes.org ([81.169.241.247]:46974 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933174AbeE2L4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:56:07 -0400
Date: Tue, 29 May 2018 13:56:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] iommu/vt-d: Improve PASID id and table management
Message-ID: <20180529115605.GI18595@8bytes.org>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
 <20180515141101.GF18595@8bytes.org>
 <5AFBE53C.2070604@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AFBE53C.2070604@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 04:01:00PM +0800, Lu Baolu wrote:
> You are right. System-wide pasid space is necessary, hence PATCH
> 1~3 implement it. But PATCH 4~9 don't go into the opposite direction,
> it's designed to address another potential issue.

Okay, thanks for the clarification. Please send me a rebased version of
this after the merge window I will review again.


Thanks,

	Joerg

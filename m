Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeC2Iwh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:52:37 -0400
Received: from 8bytes.org ([81.169.241.247]:44830 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeC2Iwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:52:36 -0400
Date: Thu, 29 Mar 2018 10:52:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu/vt-d: Global PASID name space
Message-ID: <20180329085233.aea52spusygcmxz6@8bytes.org>
References: <1521081501-30119-1-git-send-email-baolu.lu@linux.intel.com>
 <5AB840FD.8020600@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AB840FD.8020600@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 08:38:21AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> A gentle ping. :-)
> 
> Any comments on this patch set?

Yes, it doesn't apply on-top of my x86/vt-d branch. Please rebase it
after the merge-window to rc1 and re-send.


Thanks,

	Joerg

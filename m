Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeECU3b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:29:31 -0400
Received: from 8bytes.org ([81.169.241.247]:36004 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbeECU3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:29:30 -0400
Date: Thu, 3 May 2018 22:29:28 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Gary R Hook <ghook@amd.com>
Cc: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/amd - Update the PASID information printed to
 the system log
Message-ID: <20180503202928.GZ15462@8bytes.org>
References: <152520429853.30928.9793486018349326103.stgit@taos>
 <152520437211.30928.8410126837908568791.stgit@taos>
 <20180503135706.nypxlwlt7jhqhhum@8bytes.org>
 <526f3331-610f-9556-1d6d-f595d689b6de@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <526f3331-610f-9556-1d6d-f595d689b6de@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 01:09:18PM -0500, Gary R Hook wrote:
> Yes, I didn't quite get this right. Both values should be passed along. Or
> perhaps the entire event could be passed in and decoded by
> amd_iommu_report_page_fault()?

You already pass in the flags, you can chose the correct message by
looking at the GN flag there and treat the value as a domid or a pasid.


	Joerg

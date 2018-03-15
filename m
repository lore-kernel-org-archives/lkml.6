Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeCON6k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:58:40 -0400
Received: from 8bytes.org ([81.169.241.247]:42688 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbeCON6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:58:39 -0400
Date: Thu, 15 Mar 2018 14:58:38 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Add debugfs info for the AMD IOMMU
Message-ID: <20180315135838.GB5259@8bytes.org>
References: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 06:04:44PM -0500, Gary R Hook wrote:
> Gary R Hook (5):
>       iommu/amd - Add debugfs support
>       iommu/amd - Add a 'verbose' switch for IOMMU debugfs
>       iommu/amd - Add a README variable for the IOMMU debugfs
>       iommu/amd - Expose the active IOMMU device table entries
>       iommu/amd - Add a debugfs entry to specify a IOMMU device table entry

Same problem here as with the Intel patches, I don't think it's a good
idea to reveal internal iommu data structures to user-space in this way.

I've debugged iommu issues for around 10 years now and never had the
need for an interface that reveals those internals. How exactly are you
planning to use this information?



	Joerg

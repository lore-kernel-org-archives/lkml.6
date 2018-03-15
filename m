Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeCOMiU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:38:20 -0400
Received: from 8bytes.org ([81.169.241.247]:41958 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752214AbeCOMiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:38:18 -0400
Date: Thu, 15 Mar 2018 13:38:13 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de, alex.williamson@redhat.com
Subject: Re: [PATCH v4] iommu/amd: Add support for fast IOTLB flushing
Message-ID: <20180315123813.tmlce7fmd6ghe56e@8bytes.org>
References: <1519197585-10546-1-git-send-email-suravee.suthikulpanit@amd.com>
 <f9396eef-26b9-5280-1250-4aaeb0a38c32@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9396eef-26b9-5280-1250-4aaeb0a38c32@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Mon, Mar 05, 2018 at 08:08:21AM +0700, Suravee Suthikulpanit wrote:
> Ping..
> 
> Joerg, when you get a chance, would you please let me know if you have any other concerns for this v4.

Sorry for the long delay. The patch is fine, I applied it to the
iommu-tree.

Thanks,

	Joerg

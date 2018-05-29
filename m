Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933613AbeE2MJm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:09:42 -0400
Received: from 8bytes.org ([81.169.241.247]:47114 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933135AbeE2MJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:09:39 -0400
Date: Tue, 29 May 2018 14:09:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Gary R Hook <gary.hook@amd.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Message-ID: <20180529120938.GK18595@8bytes.org>
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
 <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
 <ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
 <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
 <20180515134603.GD18595@8bytes.org>
 <4041cb33-19a2-5542-4211-1dce51de5e40@amd.com>
 <89a0e3af-8970-cd80-418d-630841795807@infradead.org>
 <3eefbef8-142e-0a29-3e97-536717f63a98@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eefbef8-142e-0a29-3e97-536717f63a98@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 04:02:46PM -0500, Gary R Hook wrote:
> "Preferred", perhaps. Neither is incorrect. And really, the Makefile/Kconfig
> choice is somewhat separate from the organization issue.
> 
> So I've made the changes for this. Now I'm waiting on Joerg to make a
> decision on the code/file organization. I still prefer a separate file for
> the debug fs code.

The Kconfig option looks nicer to me, please use it. Then you can also
put the code into a separate file.


	Joerg

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeEVHky (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:40:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:48605 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbeEVHkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:40:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="56493705"
Date: Tue, 22 May 2018 10:40:49 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] MAINTAINERS: Change hugetlbfs maintainer and update files
Message-ID: <20180522074049.d4g554twdzkzbngv@black.fi.intel.com>
References: <20180518225236.19079-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518225236.19079-1-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:52:36PM +0000, Mike Kravetz wrote:
> The current hugetlbfs maintainer has not been active for more than
> a few years.  I have been been active in this area for more than
> two years and plan to remain active in the foreseeable future.
> 
> Also, update the hugetlbfs entry to include linux-mm mail list and
> additional hugetlbfs related files.  hugetlb.c and hugetlb.h are
> not 100% hugetlbfs, but a majority of their content is hugetlbfs
> related.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks!

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

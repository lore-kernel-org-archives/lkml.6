Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeEVG1I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:27:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:51651 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeEVG1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:27:07 -0400
Date: Tue, 22 May 2018 08:27:05 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] MAINTAINERS: Change hugetlbfs maintainer and update files
Message-ID: <20180522062705.GD20020@dhcp22.suse.cz>
References: <20180518225236.19079-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518225236.19079-1-mike.kravetz@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-05-18 15:52:36, Mike Kravetz wrote:
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

Thanks a lot Mike!
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  MAINTAINERS | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9051a9ca24a2..c7a5eb074eb1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6564,9 +6564,15 @@ F:	Documentation/networking/hinic.txt
>  F:	drivers/net/ethernet/huawei/hinic/
>  
>  HUGETLB FILESYSTEM
> -M:	Nadia Yvette Chambers <nyc@holomorphy.com>
> +M:	Mike Kravetz <mike.kravetz@oracle.com>
> +L:	linux-mm@kvack.org
>  S:	Maintained
>  F:	fs/hugetlbfs/
> +F:	mm/hugetlb.c
> +F:	include/linux/hugetlb.h
> +F:	Documentation/admin-guide/mm/hugetlbpage.rst
> +F:	Documentation/vm/hugetlbfs_reserv.rst
> +F:	Documentation/ABI/testing/sysfs-kernel-mm-hugepages
>  
>  HVA ST MEDIA DRIVER
>  M:	Jean-Christophe Trotin <jean-christophe.trotin@st.com>
> -- 
> 2.13.6

-- 
Michal Hocko
SUSE Labs

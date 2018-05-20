Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeETXf0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 19:35:26 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:53289 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeETXfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 19:35:25 -0400
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Mike Kravetz <mike.kravetz@oracle.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] MAINTAINERS: Change hugetlbfs maintainer and update
 files
Thread-Topic: [PATCH] MAINTAINERS: Change hugetlbfs maintainer and update
 files
Thread-Index: AQHT7vry4FsNjjBGU0KHqX9d+z4uJKQ4rmQA
Date: Sun, 20 May 2018 23:23:52 +0000
Message-ID: <20180520232352.GA7925@hori1.linux.bs1.fc.nec.co.jp>
References: <20180518225236.19079-1-mike.kravetz@oracle.com>
In-Reply-To: <20180518225236.19079-1-mike.kravetz@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.81]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D04C778E8AF1AA4A9AF674E22FB7FA72@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:52:36PM -0700, Mike Kravetz wrote:
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

Thank you for taking responsibility on this!

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

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
> 
> 

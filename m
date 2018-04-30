Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754837AbeD3SjB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 14:39:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41717 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754672AbeD3Si6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 14:38:58 -0400
Date: Mon, 30 Apr 2018 12:38:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "dongbo (E)" <dongbo4@huawei.com>
Cc: <corbet@lwn.net>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFIO: Fix Documentation
Message-ID: <20180430123857.006a0697@w520.home>
In-Reply-To: <36f5940b-cac5-9a4a-86cb-7ad9766d5d62@huawei.com>
References: <1524218521-61496-1-git-send-email-zhangshaokun@hisilicon.com>
        <36f5940b-cac5-9a4a-86cb-7ad9766d5d62@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 18:07:27 +0800
"dongbo (E)" <dongbo4@huawei.com> wrote:

> From: Dong Bo <dongbo4@huawei.com>
> 
> Signed-off-by: Dong Bo <dongbo4@huawei.com>
> ---

Hi Dong Bo,

The patch is corrupted, please resend and also include a commit log,
something as simple as "Update vfio_add_group_dev description to match
the current API" would be fine.  Thanks,

Alex

>  Documentation/vfio.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> index ef6a511..f1a4d3c 100644
> --- a/Documentation/vfio.txt
> +++ b/Documentation/vfio.txt
> @@ -252,15 +252,14 @@ into VFIO core.  When devices are bound and unbound to the driver,
>  the driver should call vfio_add_group_dev() and vfio_del_group_dev()
>  respectively::
>  -	extern int vfio_add_group_dev(struct iommu_group *iommu_group,
> -	                              struct device *dev,
> +	extern int vfio_add_group_dev(struct device *dev,
>  				      const struct vfio_device_ops *ops,
>  				      void *device_data);
>   	extern void *vfio_del_group_dev(struct device *dev);
>   vfio_add_group_dev() indicates to the core to begin tracking the
> -specified iommu_group and register the specified dev as owned by
> +iommu_group of the specified dev and register the dev as owned by
>  a VFIO bus driver.  The driver provides an ops structure for callbacks
>  similar to a file operations structure::
>  -- 1.9.1
> 
> 
> .
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeEGHxM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:53:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751042AbeEGHxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:53:10 -0400
Date: Mon, 7 May 2018 09:53:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "dongbo (E)" <dongbo4@huawei.com>
Cc: <alex.williamson@redhat.com>, <corbet@lwn.net>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio: fix documentation
Message-ID: <20180507095303.450aef9b.cohuck@redhat.com>
In-Reply-To: <eacddc78-279c-abe8-e663-9849973dd6a3@huawei.com>
References: <eacddc78-279c-abe8-e663-9849973dd6a3@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2018 11:02:10 +0800
"dongbo (E)" <dongbo4@huawei.com> wrote:

> From: Dong Bo <dongbo4@huawei.com>
> 
> Update vfio_add_group_dev description to match the current API.
> 
> Signed-off-by: Dong Bo <dongbo4@huawei.com>
> ---
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
> 
> -	extern int vfio_add_group_dev(struct iommu_group *iommu_group,
> -	                              struct device *dev,
> +	extern int vfio_add_group_dev(struct device *dev,
>  				      const struct vfio_device_ops *ops,
>  				      void *device_data);
> 
>  	extern void *vfio_del_group_dev(struct device *dev);
> 
>  vfio_add_group_dev() indicates to the core to begin tracking the
> -specified iommu_group and register the specified dev as owned by
> +iommu_group of the specified dev and register the dev as owned by
>  a VFIO bus driver.  The driver provides an ops structure for callbacks
>  similar to a file operations structure::
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

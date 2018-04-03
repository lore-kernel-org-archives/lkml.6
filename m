Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755500AbeDCLKK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:10:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755483AbeDCLKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:10:07 -0400
Date: Tue, 3 Apr 2018 13:10:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
Subject: Re: [PATCH v3 08/14] s390: vfio-ap: sysfs interfaces to configure
 adapters
Message-ID: <20180403131002.3e3cfb49.cohuck@redhat.com>
In-Reply-To: <1521051954-25715-9-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1521051954-25715-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018 14:25:48 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index a388b66..f6e7ed1 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -11,6 +11,7 @@
>  #include <linux/types.h>
>  #include <linux/device.h>
>  #include <linux/mdev.h>
> +#include <asm/kvm-ap.h>
>  
>  #include "ap_bus.h"
>  

Does this hunk belong in this patch?

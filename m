Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B00C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9F92084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9F92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeLLPud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:50:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeLLPud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:50:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6E63300250C;
        Wed, 12 Dec 2018 15:50:32 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A85E01057069;
        Wed, 12 Dec 2018 15:50:31 +0000 (UTC)
Date:   Wed, 12 Dec 2018 16:50:29 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS/vfio-ccw: add Farhan and Eric, make Halil
 Reviewer
Message-ID: <20181212165029.1e8404bd.cohuck@redhat.com>
In-Reply-To: <20181212145929.136522-1-borntraeger@de.ibm.com>
References: <20181212145929.136522-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 12 Dec 2018 15:50:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 15:59:29 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Eric and Farhan will help with maintaining vfio-ccw.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Farhan Ali <alifm@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8119141a926f..879594b93385 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13026,7 +13026,9 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
>  
>  S390 VFIO-CCW DRIVER
>  M:	Cornelia Huck <cohuck@redhat.com>
> -M:	Halil Pasic <pasic@linux.ibm.com>
> +M:	Farhan Ali <alifm@linux.ibm.com>
> +M:	Eric Farman <farman@linux.ibm.com>
> +R:	Halil Pasic <pasic@linux.ibm.com>
>  L:	linux-s390@vger.kernel.org
>  L:	kvm@vger.kernel.org
>  S:	Supported

Thanks, applied.

Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F96C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E23A2408B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E23A2408B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeGFGZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:25:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753419AbeGFGZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:25:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BDA840704A2;
        Fri,  6 Jul 2018 06:25:31 +0000 (UTC)
Received: from gondolin (ovpn-116-135.ams2.redhat.com [10.36.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F5C02156889;
        Fri,  6 Jul 2018 06:25:29 +0000 (UTC)
Date:   Fri, 6 Jul 2018 08:25:27 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Dong Jia Shi <bjsdjshi@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, legumen@foxmail.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com
Subject: Re: [PATCH 1/1] MAINTAINERS: Remove myself as maintainer
Message-ID: <20180706082527.51ddc1fa.cohuck@redhat.com>
In-Reply-To: <20180706015743.41810-1-bjsdjshi@linux.ibm.com>
References: <20180706015743.41810-1-bjsdjshi@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 06 Jul 2018 06:25:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 06 Jul 2018 06:25:31 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Jul 2018 03:57:43 +0200
Dong Jia Shi <bjsdjshi@linux.ibm.com> wrote:

> I am leaving IBM and will move on to other working area,
> so remove myself as a vfio-ccw maintainer.

:sadface:

> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
> 
> ---
> I've enjoyed working with you guys. Hope to meet you in future,
> until then, thank you for all your coach and help, please take
> care, and farewell.

Enjoyed working with you as well! Thank you for your work, and hope to
see you again :)

> 
> [I've send you my private contact data. :]
> 
> --
> Dong Jia
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 07d1576fc766..e52eb9312f2d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12398,7 +12398,6 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
>  
>  S390 VFIO-CCW DRIVER
>  M:	Cornelia Huck <cohuck@redhat.com>
> -M:	Dong Jia Shi <bjsdjshi@linux.ibm.com>
>  M:	Halil Pasic <pasic@linux.ibm.com>
>  L:	linux-s390@vger.kernel.org
>  L:	kvm@vger.kernel.org

Thanks, applied.

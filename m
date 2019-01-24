Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BF1218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfAXPGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:06:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfAXPGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:06:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 576ECC07457D;
        Thu, 24 Jan 2019 15:06:44 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12D555C1B2;
        Thu, 24 Jan 2019 15:06:39 +0000 (UTC)
Date:   Thu, 24 Jan 2019 16:06:37 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Michael Mueller <mimu@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 07/13] KVM: s390: introduce struct
 kvm_s390_gisa_interrupt
Message-ID: <20190124160637.0f8b47a7.cohuck@redhat.com>
In-Reply-To: <20190124125939.130763-8-mimu@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-8-mimu@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 24 Jan 2019 15:06:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 13:59:33 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Use this struct analog to the kvm interruption structs
> for kvm emulated floating and local interruptions.

I guess that makes sense.

> Further fields will be added with this series as
> required.

A reference to "this series" will look a bit strange if you look at the
committed patch later. What about:

"GIB handling will add further fields to this structure as required."

?

> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  6 ++++-
>  arch/s390/kvm/interrupt.c        | 52 +++++++++++++++++++++++-----------------
>  arch/s390/kvm/kvm-s390.c         |  2 +-
>  3 files changed, 36 insertions(+), 24 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

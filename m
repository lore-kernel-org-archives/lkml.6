Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F58C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED158206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfACJmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:42:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbfACJms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:42:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81E3E54388;
        Thu,  3 Jan 2019 09:42:48 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95F3B60D27;
        Thu,  3 Jan 2019 09:42:38 +0000 (UTC)
Date:   Thu, 3 Jan 2019 10:42:36 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
        dgilbert@redhat.com, pasic@linux.ibm.com
Subject: Re: [PATCH v1 2/2] virtio-balloon: improve update_balloon_size_func
Message-ID: <20190103104236.06568289.cohuck@redhat.com>
In-Reply-To: <1546493462-32244-3-git-send-email-wei.w.wang@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
        <1546493462-32244-3-git-send-email-wei.w.wang@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 03 Jan 2019 09:42:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Jan 2019 13:31:02 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> There is no need to update the balloon actual register when there is no
> ballooning request. This patch avoids update_balloon_size when diff is 0.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_balloon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

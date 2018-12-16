Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262B1C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD1C21836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbeLPTlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:41:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730770AbeLPTlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:41:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DF2A2D7F7;
        Sun, 16 Dec 2018 19:41:51 +0000 (UTC)
Received: from redhat.com (ovpn-120-77.rdu2.redhat.com [10.10.120.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 29CD31019630;
        Sun, 16 Dec 2018 19:41:48 +0000 (UTC)
Date:   Sun, 16 Dec 2018 14:41:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     ptikhomirov@virtuozzo.com, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        khorenko@virtuozzo.com
Subject: Re: [PATCH] vhost: return EINVAL if iovecs size does not match the
 message size
Message-ID: <20181216144011-mutt-send-email-mst@kernel.org>
References: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
 <20181215.114611.1702968159223320911.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215.114611.1702968159223320911.davem@davemloft.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 16 Dec 2018 19:41:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 11:46:11AM -0800, David Miller wrote:
> From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Date: Thu, 13 Dec 2018 17:53:50 +0300
> 
> > We've failed to copy and process vhost_iotlb_msg so let userspace at
> > least know about it. For instance before these patch the code below runs
> > without any error:
>  ...
> > Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> 
> Michael, will you be taking this in via your tree?
> 
> Thanks.

Will do, thanks!


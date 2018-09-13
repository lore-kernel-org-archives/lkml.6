Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6665C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462D620880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462D620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIMXMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:12:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbeIMXMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:12:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E96EE7F3F4;
        Thu, 13 Sep 2018 18:02:15 +0000 (UTC)
Received: from redhat.com (ovpn-123-50.rdu2.redhat.com [10.10.123.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id A79315D6AA;
        Thu, 13 Sep 2018 18:02:14 +0000 (UTC)
Date:   Thu, 13 Sep 2018 14:02:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     jasowang@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next V2 00/11] vhost_net TX batching
Message-ID: <20180913135833-mutt-send-email-mst@kernel.org>
References: <20180912031709.14112-1-jasowang@redhat.com>
 <20180913.092819.2099750169529223026.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913.092819.2099750169529223026.davem@davemloft.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Sep 2018 18:02:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 09:28:19AM -0700, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Wed, 12 Sep 2018 11:16:58 +0800
> 
> > This series tries to batch submitting packets to underlayer socket
> > through msg_control during sendmsg(). This is done by:
>  ...
> 
> Series applied, thanks Jason.

Going over it now I don't see a lot to complain about, but I'd
appreciate a bit more time for review in the future. 3 days ok?

-- 
MST

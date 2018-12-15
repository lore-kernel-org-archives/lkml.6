Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46A1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B1B2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeLOTqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:46:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54198 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeLOTqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:46:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E44E714E8B9D2;
        Sat, 15 Dec 2018 11:46:11 -0800 (PST)
Date:   Sat, 15 Dec 2018 11:46:11 -0800 (PST)
Message-Id: <20181215.114611.1702968159223320911.davem@davemloft.net>
To:     ptikhomirov@virtuozzo.com
Cc:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, khorenko@virtuozzo.com
Subject: Re: [PATCH] vhost: return EINVAL if iovecs size does not match the
 message size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
References: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 11:46:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Date: Thu, 13 Dec 2018 17:53:50 +0300

> We've failed to copy and process vhost_iotlb_msg so let userspace at
> least know about it. For instance before these patch the code below runs
> without any error:
 ...
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Michael, will you be taking this in via your tree?

Thanks.

Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A37C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2022320857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2022320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeGaSof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:44:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbeGaSof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:44:35 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 09F36100AB632;
        Tue, 31 Jul 2018 10:03:22 -0700 (PDT)
Date:   Tue, 31 Jul 2018 10:03:21 -0700 (PDT)
Message-Id: <20180731.100321.2201791423933345752.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        makita.toshiaki@lab.ntt.co.jp
Subject: Re: [PATCH net-next 2/2] virtio-net: get rid of unnecessary
 container of rq stats
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533030219-9904-2-git-send-email-jasowang@redhat.com>
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
        <1533030219-9904-2-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 31 Jul 2018 10:03:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Jul 2018 17:43:39 +0800

> We don't maintain tx counters in rx stats any more. There's no need
> for an extra container of rq stats.
> 
> Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied.

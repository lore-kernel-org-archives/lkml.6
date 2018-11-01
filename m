Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24777C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0ADA205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0ADA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeKBD5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:57:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44152 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKBD5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:57:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D325713FEE803;
        Thu,  1 Nov 2018 11:53:24 -0700 (PDT)
Date:   Thu, 01 Nov 2018 11:53:13 -0700 (PDT)
Message-Id: <20181101.115313.2041743634297599056.davem@davemloft.net>
To:     khlebnikov@yandex-team.ru
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        vfedorenko@yandex-team.ru
Subject: Re: [PATCH resend] macvlan: use per-cpu queues for broadcast and
 multicast packets
From:   David Miller <davem@davemloft.net>
In-Reply-To: <154108883150.919735.10620997593741055347.stgit@buzz>
References: <154108883150.919735.10620997593741055347.stgit@buzz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 01 Nov 2018 11:53:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date: Thu, 01 Nov 2018 19:13:51 +0300

> Currently macvlan has single per-port queue for broadcast and multicast.
> This disrupts order of packets when flows from different cpus are mixed.
> 
> This patch replaces this queue with single set of per-cpu queues.
> Pointer to macvlan port is passed in skb control block.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Reported-add-tested-by: Vadim Fedorenko <vfedorenko@yandex-team.ru>

Konstantin, all of your postings to vger.kernel.org are being rejected.

They are because of the:

"List-Unsubscribe: <https://ml.yandex-team.ru/lists/vfedorenko@yandex-team.ru/unsubscribe-click>"

and similar strings that appear in your email headers.

Please disable whatever is producing these email headers, otherwise
nobody (including me) will see and process your postings.

Thank you.

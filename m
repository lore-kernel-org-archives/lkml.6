Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4E6C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3B920881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfA3XJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:09:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52288 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfA3XJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:09:59 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CA64414F5E72C;
        Wed, 30 Jan 2019 14:31:17 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:31:17 -0800 (PST)
Message-Id: <20190130.143117.30926981436378456.davem@davemloft.net>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, stefanha@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: fix OOB in get_rx_bufs()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190129203157-mutt-send-email-mst@kernel.org>
References: <20190129.151026.358327408932275252.davem@davemloft.net>
        <20190129.153810.493942539151548676.davem@davemloft.net>
        <20190129203157-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 30 Jan 2019 14:31:18 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 29 Jan 2019 20:36:31 -0500

> If it helps I can include most virtio stuff in my pull requests instead.
> Or if that can't work since there's too often a dependency on net-next,
> maybe Jason wants to create a tree and send pull requests to you.  Let
> us know if that will help, and which of the options looks better from
> your POV.

Thanks for offering Michael, I really appreciate it.

Let me think about the logistics of that and how it may or may not
help me with my backlog.

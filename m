Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B7BC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F8221734
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfAUSs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:48:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50124 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfAUSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:48:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0199E14C716E7;
        Mon, 21 Jan 2019 10:48:26 -0800 (PST)
Date:   Mon, 21 Jan 2019 10:48:24 -0800 (PST)
Message-Id: <20190121.104824.1888946069199769292.davem@davemloft.net>
To:     ian.kumlien@gmail.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAA85sZtizu_uvHhevg_B1Ok7K=O_J=agAmG5ic7M=1by5BCurw@mail.gmail.com>
References: <CAA85sZum33M+1NRcfWkua+66CBTxM8ope+hoGASv6mR8NrwPTg@mail.gmail.com>
        <20190121151020.GB4717@kroah.com>
        <CAA85sZtizu_uvHhevg_B1Ok7K=O_J=agAmG5ic7M=1by5BCurw@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 21 Jan 2019 10:48:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Mon, 21 Jan 2019 16:38:11 +0100

> Hi David,
> 
> could we have your blessing to add the following patch to -stable for 4.20.4:
> commit 41d1c8839e5f8cb781cc635f12791decee8271b7
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Tue Jan 8 18:45:05 2019 +0100
> 
>     net: clear skb->tstamp in bridge forwarding path

It is already in my -stable queue:

https://patchwork.ozlabs.org/bundle/davem/stable/?series=&submitter=&state=*&q=&archive=

I honestly don't know why I bother putting forth such an effort to publish
what is in my -stable queue if people don't bother checking it. :-(

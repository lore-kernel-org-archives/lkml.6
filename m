Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A156C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3730320844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfAUTnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:43:42 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50694 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfAUTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:43:38 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 377A414C756B2;
        Mon, 21 Jan 2019 11:43:38 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:43:35 -0800 (PST)
Message-Id: <20190121.114335.1161077933505726939.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
Cc:     ian.kumlien@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190121192148.GC4026@kroah.com>
References: <CAA85sZtizu_uvHhevg_B1Ok7K=O_J=agAmG5ic7M=1by5BCurw@mail.gmail.com>
        <20190121.104824.1888946069199769292.davem@davemloft.net>
        <20190121192148.GC4026@kroah.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 21 Jan 2019 11:43:38 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 21 Jan 2019 20:21:48 +0100

> Subject: [PATCH] stable-kernel-rules.rst: add link to networking patch queue
> 
> The networking maintainer keeps a public list of the patches being
> queued up for the next round of stable releases.  Be sure to check there
> before asking for a patch to be applied so that you do not waste
> people's time.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: David S. Miller <davem@davemloft.net>

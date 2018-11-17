Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D134C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020B420824
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020B420824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeKQOCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 09:02:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48202 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQOCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 09:02:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CCEE213F5C64D;
        Fri, 16 Nov 2018 19:47:39 -0800 (PST)
Date:   Fri, 16 Nov 2018 19:47:39 -0800 (PST)
Message-Id: <20181116.194739.1234724172712558692.davem@davemloft.net>
To:     christophe.jaillet@wanadoo.fr
Cc:     hauke@hauke-m.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: lantiq: Fix returned value in case of error in
 'xrx200_probe()'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181113174224.7884-1-christophe.jaillet@wanadoo.fr>
References: <20181113174224.7884-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Nov 2018 19:47:40 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Tue, 13 Nov 2018 18:42:24 +0100

> Return 'err' in the error handling path instead of 0.
> Return explicitly 0 in the normal path, instead of 'err', which is known
> to be 0 at this point.
> 
> Fixes: fe1a56420cf2 ("net: lantiq: Add Lantiq / Intel VRX200 Ethernet driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.

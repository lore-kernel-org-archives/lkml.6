Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6BBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FFF21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfBSAg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:36:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56686 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfBSAg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:36:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F071F11D424B2;
        Mon, 18 Feb 2019 16:36:26 -0800 (PST)
Date:   Mon, 18 Feb 2019 16:36:26 -0800 (PST)
Message-Id: <20190218.163626.780835750717136767.davem@davemloft.net>
To:     rdong.ge@gmail.com
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: Implement flow_dissect callback for
 tag_dsa.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190216083524.860-1-rdong.ge@gmail.com>
References: <20190216083524.860-1-rdong.ge@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 16:36:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rundong Ge <rdong.ge@gmail.com>
Date: Sat, 16 Feb 2019 08:35:24 +0000

> RPS not work for DSA devices since the 'skb_get_hash'
> will always get the invalid hash for dsa tagged packets.
> 
> "[PATCH] tag_mtk: add flow_dissect callback to the ops struct"
> introduced the flow_dissect callback to get the right hash for
> MTK tagged packet. Tag_dsa and tag_edsa  also need to implement
> the callback.
> 
> Signed-off-by: Rundong Ge <rdong.ge@gmail.com>

Applied to net-next.

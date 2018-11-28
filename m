Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB302C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDDF20665
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDDF20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeK1LWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:22:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46810 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeK1LWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:22:43 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 206ED13D059E5;
        Tue, 27 Nov 2018 16:23:05 -0800 (PST)
Date:   Tue, 27 Nov 2018 16:23:04 -0800 (PST)
Message-Id: <20181127.162304.1089705109317922436.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     romieu@fr.zoreil.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: via: via-velocity: fix spelling mistake
 "alignement" -> "alignment"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181126153401.20982-1-colin.king@canonical.com>
References: <20181126153401.20982-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 27 Nov 2018 16:23:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 26 Nov 2018 15:34:01 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The text in array velocity_gstrings contains a spelling mistake,
> rename rx_frame_alignement_errors to rx_frame_alignment_errors.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.

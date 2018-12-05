Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DFA20661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DFA20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeLEE1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 23:27:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54260 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEE1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 23:27:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8E6F41423A945;
        Tue,  4 Dec 2018 20:27:36 -0800 (PST)
Date:   Tue, 04 Dec 2018 20:26:31 -0800 (PST)
Message-Id: <20181204.202631.1506678538069123479.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] qed: fix spelling mistake "Dispalying" ->
 "Displaying"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181203171331.29869-1-colin.king@canonical.com>
References: <20181203171331.29869-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 04 Dec 2018 20:27:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon,  3 Dec 2018 17:13:31 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a DP_NOTICE message, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.

Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FBEC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55D02081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55D02081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeLDAFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:05:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50528 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:04:59 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6C5E3133E98FA;
        Mon,  3 Dec 2018 16:04:59 -0800 (PST)
Date:   Mon, 03 Dec 2018 16:04:58 -0800 (PST)
Message-Id: <20181203.160458.1881785103622263316.davem@davemloft.net>
To:     alacn1@gmail.com
Cc:     andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] mv88e6060: disable hardware level MAC learning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181130235836.11741-1-alacn1@gmail.com>
References: <20181130235836.11741-1-alacn1@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Dec 2018 16:04:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anderson Luiz Alves <alacn1@gmail.com>
Date: Fri, 30 Nov 2018 21:58:36 -0200

> Disable hardware level MAC learning because it breaks station roaming.
> When enabled it drops all frames that arrive from a MAC address
> that is on a different port at learning table.
> 
> Signed-off-by: Anderson Luiz Alves <alacn1@gmail.com>
> ---
> 
> Notes:
>     v2: Updated code comments.
>     v3: Sent with correct whitespaces.

Applied, thanks.

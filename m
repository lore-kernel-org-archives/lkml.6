Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C434C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C597A206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C597A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeKFKaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:30:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37272 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKFKaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:30:06 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E56F114A67DF2;
        Mon,  5 Nov 2018 17:07:33 -0800 (PST)
Date:   Mon, 05 Nov 2018 17:07:33 -0800 (PST)
Message-Id: <20181105.170733.546721624730446725.davem@davemloft.net>
To:     matwey@sai.msu.ru
Cc:     matwey.kornilov@gmail.com, edumazet@google.com, mingo@kernel.org,
        tglx@linutronix.de, frederic@kernel.org, dbanerje@akamai.com,
        davej@codemonkey.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: netpoll: Enable netconsole IPv6 link local
 address
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181102181936.26294-1-matwey@sai.msu.ru>
References: <20181102181936.26294-1-matwey@sai.msu.ru>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 17:07:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date: Fri,  2 Nov 2018 21:19:36 +0300

> There is no reason to discard using source link local address when
> remote netconsole IPv6 address is set to be link local one.
> 
> The patch allows administrators to use IPv6 netconsole without
> explicitly configuring source address:
> 
>     netconsole=@/,@fe80::5054:ff:fe2f:6012/
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>

Applied.

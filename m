Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574EDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A00E2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfAAVxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:53:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60264 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfAAVxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:53:17 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BD28B14B799CB;
        Tue,  1 Jan 2019 13:44:33 -0800 (PST)
Date:   Tue, 01 Jan 2019 13:44:33 -0800 (PST)
Message-Id: <20190101.134433.394702619292998613.davem@davemloft.net>
To:     murali.policharla@broadcom.com
Cc:     amritha.nambiar@intel.com, ecree@solarflare.com,
        ktkhai@virtuozzo.com, alexander.h.duyck@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: Fix to store new mtu setting in netdevice.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 01 Jan 2019 13:44:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murali Krishna Policharla <murali.policharla@broadcom.com>
Date: Tue,  1 Jan 2019 12:12:14 +0530

> Store newly configured mtu settings in the netdevice after mtu
> configuration is successful to the dsa switch.
> 
> Fixes: 2315dc91a5 ("net: make dev_set_mtu() honor notification return code")
> Signed-off-by: Murali Krishna Policharla <murali.policharla@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

It is entirely premature to mention DSA in this commit message when
the DSA code lacks the callback yet.

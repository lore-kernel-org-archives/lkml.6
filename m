Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF3C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4F42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeLGVGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:06:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37604 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbeLGVGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:06:41 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D96D9119D0EED;
        Fri,  7 Dec 2018 13:06:40 -0800 (PST)
Date:   Fri, 07 Dec 2018 13:06:40 -0800 (PST)
Message-Id: <20181207.130640.1346480152696055975.davem@davemloft.net>
To:     pabeni@redhat.com
Cc:     netdev@vger.kernel.org, eric.dumazet@gmail.com, pjt@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: mitigate retpoline overhead
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c8ebc324a2195942f2a8ba2190b7e18f7b5ed0e2.camel@redhat.com>
References: <20181206.222409.551374562843523036.davem@davemloft.net>
        <20181206.222855.1688568512001921392.davem@redhat.com>
        <c8ebc324a2195942f2a8ba2190b7e18f7b5ed0e2.camel@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Dec 2018 13:06:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 07 Dec 2018 21:29:20 +0100

> Are you building with CONFIG_IPV6=m ?

I always build allmodconfig

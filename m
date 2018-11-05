Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CBAC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A797720685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A797720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeKEKIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:08:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeKEKIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:08:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 884171484C8C8;
        Sun,  4 Nov 2018 16:51:11 -0800 (PST)
Date:   Sun, 04 Nov 2018 16:51:11 -0800 (PST)
Message-Id: <20181104.165111.1752269335871104744.davem@davemloft.net>
To:     tiny.windzz@gmail.com
Cc:     edumazet@google.com, willemb@google.com, dja@axtens.net,
        ast@kernel.org, sbrivio@redhat.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: skbuff.h: remove unnecessary unlikely()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181104131444.4049-1-tiny.windzz@gmail.com>
References: <20181104131444.4049-1-tiny.windzz@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 04 Nov 2018 16:51:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Networking patches must be submitted to netdev@vger.kernel.org

Thank you.

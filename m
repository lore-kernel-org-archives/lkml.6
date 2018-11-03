Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9735DC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6671F2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6671F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeKCPpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 11:45:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46138 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKCPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 11:45:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0A78014525CCC;
        Fri,  2 Nov 2018 23:34:58 -0700 (PDT)
Date:   Fri, 02 Nov 2018 23:34:57 -0700 (PDT)
Message-Id: <20181102.233457.1315241595066674655.davem@davemloft.net>
To:     malat@debian.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: document skb parameter in function
 'skb_gso_size_check'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181031121659.30764-1-malat@debian.org>
References: <20181031121659.30764-1-malat@debian.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 02 Nov 2018 23:34:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 31 Oct 2018 13:16:58 +0100

> Remove kernel-doc warning:
> 
>   net/core/skbuff.c:4953: warning: Function parameter or member 'skb' not described in 'skb_gso_size_check'
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Qq1HBTCSGVtZOQAAmS7hNA
	; Thu, 07 Jun 2018 20:15:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EE4AE6074D; Thu,  7 Jun 2018 20:15:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 46A8E60290;
	Thu,  7 Jun 2018 20:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46A8E60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932368AbeFGUPA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:15:00 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33696 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeFGUO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:14:59 -0400
Received: from localhost (unknown [66.187.232.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9ADE310870F7F;
        Thu,  7 Jun 2018 13:14:55 -0700 (PDT)
Date: Thu, 07 Jun 2018 16:14:52 -0400 (EDT)
Message-Id: <20180607.161452.1271957567550098372.davem@davemloft.net>
To: pablo@netfilter.org
Cc: arnd@arndb.de, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        ecklm94@gmail.com, pabeni@redhat.com, willemb@google.com,
        edumazet@google.com, dsahern@gmail.com, kafai@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: provide udp*_lib_lookup for nf_tproxy
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180606133324.537naj6trahiq26f@salvia>
References: <20180605114056.1239571-1-arnd@arndb.de>
        <20180605.105453.339908802413146875.davem@davemloft.net>
        <20180606133324.537naj6trahiq26f@salvia>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Jun 2018 13:14:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Wed, 6 Jun 2018 15:33:24 +0200

> BTW, could you also pick this fix for net-next?
> 
> http://patchwork.ozlabs.org/patch/924706/

Sorry, I just noticed this now.

Applied.

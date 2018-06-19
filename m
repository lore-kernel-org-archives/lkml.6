Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFA3C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B143E20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B143E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754046AbeFSW6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:58:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeFSW57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:57:59 -0400
Received: from localhost (unknown [61.102.160.116])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3ECF01435F3F2;
        Tue, 19 Jun 2018 15:57:58 -0700 (PDT)
Date:   Wed, 20 Jun 2018 07:57:56 +0900 (KST)
Message-Id: <20180620.075756.585279541126752650.davem@davemloft.net>
To:     liran.alon@oracle.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        idan.brown@oracle.com
Subject: Re: [PATCH] net: net_failover: fix typo in
 net_failover_slave_register()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1529323445-23777-1-git-send-email-liran.alon@oracle.com>
References: <1529323445-23777-1-git-send-email-liran.alon@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Jun 2018 15:57:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liran Alon <liran.alon@oracle.com>
Date: Mon, 18 Jun 2018 15:04:05 +0300

> Sync both unicast and multicast lists instead of unicast twice.
> 
> Fixes: cfc80d9a116 ("net: Introduce net_failover driver")
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>

Applied.

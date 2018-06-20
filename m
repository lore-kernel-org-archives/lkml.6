Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C723C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311C320652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311C320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeFTXjx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:39:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45198 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbeFTXjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:39:51 -0400
Received: from localhost (unknown [61.102.160.122])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 85F78146FA32E;
        Wed, 20 Jun 2018 16:39:50 -0700 (PDT)
Date:   Thu, 21 Jun 2018 08:39:45 +0900 (KST)
Message-Id: <20180621.083945.1673251234112481148.davem@davemloft.net>
To:     robert.jarzmik@free.fr
Cc:     daniel@zonque.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 07/14] net: smc911x: remove the dmaengine compat need
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87muvppebs.fsf@belgarion.home>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180617170217.24177-8-robert.jarzmik@free.fr>
        <87muvppebs.fsf@belgarion.home>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Jun 2018 16:39:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Wed, 20 Jun 2018 19:17:43 +0200

> Could you (or somebody from netdev) review it and either ack it (and I'll take
> it through the pxa tree), or take it for v4.19 please ?

Acked-by: David S. Miller <davem@davemloft.net>


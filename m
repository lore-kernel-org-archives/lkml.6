Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B823ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1787620882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1787620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeIOCdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:33:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41222 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIOCdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:33:05 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7764F142A39DC;
        Fri, 14 Sep 2018 14:16:51 -0700 (PDT)
Date:   Fri, 14 Sep 2018 14:16:50 -0700 (PDT)
Message-Id: <20180914.141650.1899234204768709995.davem@davemloft.net>
To:     r.aviolat@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE: ide-dma: fix coding style issues with spaces
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180914202540.11977-1-r.aviolat@gmail.com>
References: <20180914202540.11977-1-r.aviolat@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Sep 2018 14:16:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Romain Aviolat <r.aviolat@gmail.com>
Date: Fri, 14 Sep 2018 22:25:40 +0200

> Fixing multiple coding style issues:
> 	* prohibited spaces before that ','
> 	* spaces before tabs
> 
> Signed-off-by: Romain Aviolat <r.aviolat@gmail.com>

This kind of coding style fix has very little value for a subsystem
which is essentially frozen from changes, and to which the less
changes that happen to it the better in order to avoid potential
regressions.

Therefore I am not applying this patch, sorry.

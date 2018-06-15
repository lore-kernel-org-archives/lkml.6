Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0127C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F9C208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F9C208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966015AbeFOQPi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:15:38 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59582 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964779AbeFOQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:15:37 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D28D614214B36;
        Fri, 15 Jun 2018 09:15:36 -0700 (PDT)
Date:   Fri, 15 Jun 2018 09:15:36 -0700 (PDT)
Message-Id: <20180615.091536.1647251866604964944.davem@davemloft.net>
To:     jiazhouyang09@gmail.com
Cc:     santosh@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: cxgb3: add error handling for
 sysfs_create_group
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1529031977-57911-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528984571-53320-1-git-send-email-jiazhouyang09@gmail.com>
        <1529031977-57911-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Jun 2018 09:15:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>
Date: Fri, 15 Jun 2018 11:06:17 +0800

> When sysfs_create_group fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling sysfs_create_group.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
> v1->v2:
> - Turn off led when sysfs_create_group fails

Applied, thank you.

Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40420C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181F1214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfAJOfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:35:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46332 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfAJOfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:35:36 -0500
Received: from localhost (unknown [66.187.232.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1820C13DB8D3A;
        Thu, 10 Jan 2019 06:35:34 -0800 (PST)
Date:   Thu, 10 Jan 2019 06:35:33 -0800 (PST)
Message-Id: <20190110.063533.1818475173357197849.davem@davemloft.net>
To:     khlebnikov@yandex-team.ru
Cc:     netdev@vger.kernel.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/core/neighbour: tell kmemleak about hash tables
From:   David Miller <davem@davemloft.net>
In-Reply-To: <154693980088.104235.16222977463502002037.stgit@buzz>
References: <154693980088.104235.16222977463502002037.stgit@buzz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 10 Jan 2019 06:35:35 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date: Tue, 08 Jan 2019 12:30:00 +0300

> This fixes false-positive kmemleak reports about leaked neighbour entries:
 ...
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Applied.

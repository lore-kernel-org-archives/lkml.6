Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23991C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF766217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfAWEwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 23:52:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40638 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAWEwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 23:52:06 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 248DB14D75785;
        Tue, 22 Jan 2019 20:52:06 -0800 (PST)
Date:   Tue, 22 Jan 2019 20:52:05 -0800 (PST)
Message-Id: <20190122.205205.1509646710585096797.davem@davemloft.net>
To:     stefan@agner.ch
Cc:     fugang.duan@nxp.com, marcel.ziswiler@toradex.com,
        max.krummenacher@toradex.com, dev@pschenker.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fec: get regulator optional
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190121145847.30223-1-stefan@agner.ch>
References: <20190121145847.30223-1-stefan@agner.ch>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 22 Jan 2019 20:52:06 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>
Date: Mon, 21 Jan 2019 15:58:47 +0100

> According to the device tree binding the phy-supply property is
> optional. Use the regulator_get_optional API accordingly. The
> code already handles NULL just fine.
> 
> This gets rid of the following warning:
>   fec 2188000.ethernet: 2188000.ethernet supply phy not found, using dummy regulator
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied.

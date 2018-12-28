Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817CDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A74A20856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbeL1ATz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:19:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51902 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeL1ATy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:19:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8BA6714E0964B;
        Thu, 27 Dec 2018 16:19:53 -0800 (PST)
Date:   Thu, 27 Dec 2018 16:19:53 -0800 (PST)
Message-Id: <20181227.161953.1630745956164164839.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, shannon.nelson@oracle.com,
        colin.king@canonical.com, rob@taglang.io, joe@perches.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet: (niu) fix missing checks of
 niu_pci_eeprom_read
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181225075617.68058-1-kjlu@umn.edu>
References: <20181225075617.68058-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Dec 2018 16:19:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 25 Dec 2018 01:56:14 -0600

> niu_pci_eeprom_read() may fail, so we should check its return value
> before using the read data.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied.

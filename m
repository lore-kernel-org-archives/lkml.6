Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD43C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E2F217D9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfBQXlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:41:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42794 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfBQXlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:41:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 62F7A12339A63;
        Sun, 17 Feb 2019 15:41:01 -0800 (PST)
Date:   Sun, 17 Feb 2019 15:41:01 -0800 (PST)
Message-Id: <20190217.154101.186880269382689521.davem@davemloft.net>
To:     bgalvani@redhat.com
Cc:     bjorn@mork.no, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qmi_wwan: apply SET_DTR quirk to Sierra WP7607
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190215122042.23195-1-bgalvani@redhat.com>
References: <20190215122042.23195-1-bgalvani@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 17 Feb 2019 15:41:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beniamino Galvani <bgalvani@redhat.com>
Date: Fri, 15 Feb 2019 13:20:42 +0100

> The 1199:68C0 USB ID is reused by Sierra WP7607 which requires the DTR
> quirk to be detected. Apply QMI_QUIRK_SET_DTR unconditionally as
> already done for other IDs shared between different devices.
> 
> Signed-off-by: Beniamino Galvani <bgalvani@redhat.com>

Applied.

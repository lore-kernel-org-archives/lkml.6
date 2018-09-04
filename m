Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AFAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5222086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5222086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeIDG15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:27:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeIDG15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:27:57 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 29A501449D9FA;
        Mon,  3 Sep 2018 19:05:09 -0700 (PDT)
Date:   Mon, 03 Sep 2018 19:05:08 -0700 (PDT)
Message-Id: <20180903.190508.740770038342700188.davem@davemloft.net>
To:     anthony.wong@ubuntu.com
Cc:     nic_swsd@realtek.com, bhelgaas@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] r8169: add support for NCube 8168 network card
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1535717202-26397-1-git-send-email-anthony.wong@ubuntu.com>
References: <1535717202-26397-1-git-send-email-anthony.wong@ubuntu.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Sep 2018 19:05:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Wong <anthony.wong@ubuntu.com>
Date: Fri, 31 Aug 2018 20:06:42 +0800

> This card identifies itself as:
>   Ethernet controller [0200]: NCube Device [10ff:8168] (rev 06)
>   Subsystem: TP-LINK Technologies Co., Ltd. Device [7470:3468]
> 
> Adding a new entry to rtl8169_pci_tbl makes the card work.
> 
> Link: http://launchpad.net/bugs/1788730
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Anthony Wong <anthony.wong@ubuntu.com>

Applied.

Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52603C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D722F2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D722F2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbeHNG3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 02:29:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38112 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbeHNG3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 02:29:21 -0400
Received: from localhost (unknown [172.58.41.230])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BBB6212173DA1;
        Mon, 13 Aug 2018 20:44:08 -0700 (PDT)
Date:   Mon, 13 Aug 2018 20:44:02 -0700 (PDT)
Message-Id: <20180813.204402.1421407035478593990.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     Bryan.Whitehead@microchip.com, andrew@lunn.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: lan743x: select CRC16
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180813211938.2375199-1-arnd@arndb.de>
References: <20180813211938.2375199-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 20:44:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Aug 2018 23:19:21 +0200

> lan743x now fails to build when CONFIG_CRC16 is disabled:
> 
> drivers/net/ethernet/microchip/lan743x_main.o: In function crc16'
> 
> Force it on like all other users do.
> 
> Fixes: 4d94282afd95 ("lan743x: Add power management support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.

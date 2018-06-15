Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 50A0AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1301F208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1301F208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965251AbeFOAJU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:09:20 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51076 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965109AbeFOAJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:09:18 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0D7A4141102E1;
        Thu, 14 Jun 2018 17:09:18 -0700 (PDT)
Date:   Thu, 14 Jun 2018 17:09:17 -0700 (PDT)
Message-Id: <20180614.170917.1206663847215606546.davem@davemloft.net>
To:     laoar.shao@gmail.com
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: add SNMP counter for zero-window drops
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1528889908-15980-1-git-send-email-laoar.shao@gmail.com>
References: <1528889908-15980-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Jun 2018 17:09:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 13 Jun 2018 07:38:28 -0400

> It will be helpful if we could display the drops due to zero window or no
> enough window space.
> So a new SNMP MIB entry is added to track this behavior.
> This entry is named LINUX_MIB_TCPZEROWINDOWDROP and published in
> /proc/net/netstat in TcpExt line as TCPZeroWindowDrop.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

net-next is closed, please resubmit this when net-next opens
back up.

Thank you.

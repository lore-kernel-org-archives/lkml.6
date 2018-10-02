Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8BDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC572089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC572089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJBNLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:11:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38388 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeJBNLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:11:46 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::30d2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ECB1411693725;
        Mon,  1 Oct 2018 23:30:09 -0700 (PDT)
Date:   Mon, 01 Oct 2018 23:30:09 -0700 (PDT)
Message-Id: <20181001.233009.1935570426554093483.davem@davemloft.net>
To:     robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew@lunn.ch,
        netdev@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH RESEND] net: phy: Convert to using %pOFn instead of
 device_node.name
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180928220459.11385-1-robh@kernel.org>
References: <20180928220459.11385-1-robh@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Oct 2018 23:30:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Sep 2018 17:04:59 -0500

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> David, Resending because you superseded this one for some reason. It 
> shouldn't be. Perhaps because the subject was similar to others?

Applied, thanks.

Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514B0C46475
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 23:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEE820659
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 23:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IrHbxkg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEE820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeJGG72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 02:59:28 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55884 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbeJGG72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 02:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=j25/eU24iVot+n73hmUcV/3FiTMhTW2RlyUhS6fQN2c=;
        b=IrHbxkg4fqZ8p1EhABDIlJwrSe0oAcioPw/L2Ma5xtif13RVv11FCJ1Eaf5d+IpA781Kkkny30IhEYsqUtHbxN6nMMpnj4T2y9j/2Qd3X2U7v5K+kgfmPl35JejazvoybRRsb5HTk+g52PYuEKtUdldTmRPUi3JcVncD4cqOv5M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g8wOk-0003M9-88; Sun, 07 Oct 2018 01:54:14 +0200
Date:   Sun, 7 Oct 2018 01:54:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
Message-ID: <20181006235414.GA11773@lunn.ch>
References: <20181006025709.4019-1-Jason@zx2c4.com>
 <20181006025709.4019-29-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006025709.4019-29-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason

The BUG() statements all seemed to be removed. Thanks.

We still have 1 errors, 193 warnings, 7529 lines checked from
checkpatch. There are still some Macros flow control statements in
them, despite me pointed them out multiple times.

Im not reviewing this version any further. Until you get the very
basics right, i doubt this patch is going to make much progress
towards inclusion.

   Andrew

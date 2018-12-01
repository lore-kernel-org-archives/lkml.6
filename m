Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A2C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A06D20673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U0rr6SnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A06D20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeLBCwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:52:00 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57124 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLBCv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=TbnVSvHg9Mv8H3d6P72OKwoXHQUQkMDUCzP+ouE+VIA=;
        b=U0rr6SnZzjiugTo+U60Tz6ZviXG49wShY4+/w5mNGNwG1bpQm8u25kkGQw/KvetV9mADxZOiXPx+429J+/J6TbZZpLV6qODlV/sMWciJ7wACcJV6vEDiXtuGaCuOeCgrhWwFd2BYF3L2546rbjxC2PrsirR494mJ8lgfMzII/3I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gT7MG-0004JT-8w; Sat, 01 Dec 2018 16:39:04 +0100
Date:   Sat, 1 Dec 2018 16:39:04 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Anderson Luiz Alves <alacn1@gmail.com>
Cc:     vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] mv88e6060: disable hardware level MAC learning
Message-ID: <20181201153904.GA16447@lunn.ch>
References: <20181130235836.11741-1-alacn1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130235836.11741-1-alacn1@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 09:58:36PM -0200, Anderson Luiz Alves wrote:
> Disable hardware level MAC learning because it breaks station roaming.
> When enabled it drops all frames that arrive from a MAC address
> that is on a different port at learning table.
> 
> Signed-off-by: Anderson Luiz Alves <alacn1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Hi Anderson

One more process thing. You should add any Reviewed-by, Acked-by tags
you get when posting a new version. However, there is no need for a v4
for just this.

    Andrew

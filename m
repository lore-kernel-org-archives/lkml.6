Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05CEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE887222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ylWqmNwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfBPPmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:42:51 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55041 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfBPPmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=O9Mf5/Oor2yZQth8a/WAkQJWJAuquzjtBgTn+QV6kwE=; b=ylWqmNwD3yOLdEohzMtjYC4xh3
        O3vpWdquqgNuOyVtq/SQ06b++eInuHkn757tzC6gVWnSFIb/2fvKpKafoUG9NJerd25FaWfgLm/ct
        ++nuilhmY3Xdvs4nIAMUBsiBQNrrjT4ndyL+JqQG1n5LzEQi/vZafGV3oNyPvFGYxq64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gv276-000057-2i; Sat, 16 Feb 2019 16:42:48 +0100
Date:   Sat, 16 Feb 2019 16:42:48 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rundong Ge <rdong.ge@gmail.com>
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: Implement flow_dissect callback for tag_dsa.
Message-ID: <20190216154248.GN5699@lunn.ch>
References: <20190216083524.860-1-rdong.ge@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216083524.860-1-rdong.ge@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 08:35:24AM +0000, Rundong Ge wrote:
> RPS not work for DSA devices since the 'skb_get_hash'
> will always get the invalid hash for dsa tagged packets.
> 
> "[PATCH] tag_mtk: add flow_dissect callback to the ops struct"
> introduced the flow_dissect callback to get the right hash for
> MTK tagged packet. Tag_dsa and tag_edsa  also need to implement
> the callback.
> 
> Signed-off-by: Rundong Ge <rdong.ge@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

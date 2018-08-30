Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35297C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB470205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="eIJ44RW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB470205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeH3QLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:11:23 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:38344 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeH3QLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:11:23 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id F1F6125B7DC;
        Thu, 30 Aug 2018 22:09:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1535630971; bh=K2romkvmw2d+ENUf81Q8hIUNcfQUhGxYYeMiKFEGvsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIJ44RW0InD8suS7tjTKtjrUBdfsFVvvXI5h3b+3R4SbCVfbwuKLwJtEpG9nNmiqu
         nZHGuEBoMX0HAQ2z5TFhuBCPXkdEed49yv2x9meAoRlFzJP/wpJlAtRi0YcgNxDU26
         nX5vT1tAIeLyVcfolLjzQthvJlQleSkpHKB9SrxE=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 0009B9403D6; Thu, 30 Aug 2018 14:09:28 +0200 (CEST)
Date:   Thu, 30 Aug 2018 14:09:28 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774a1
Message-ID: <20180830120928.uint4se2lfh2eklh@verge.net.au>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535097375-5561-5-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535097375-5561-5-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 08:56:13AM +0100, Fabrizio Castro wrote:
> From: Biju Das <biju.das@bp.renesas.com>
> 
> This patch adds binding for r8a774a1 (RZ/G2M).
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


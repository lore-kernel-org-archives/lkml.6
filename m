Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82499C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FC420846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="JxSl1VKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FC420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbeGKNdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:33:12 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47635 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732469AbeGKNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:33:11 -0400
Received: from penelope.horms.nl (52D9BC73.cm-11-1c.dynamic.ziggo.nl [82.217.188.115])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 26A8525B78A;
        Wed, 11 Jul 2018 23:28:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1531315728; bh=UGf0DYizFlyadhME8KdCGFDWlTIVLQFqHMiixJ3Ikx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxSl1VKEoAy1+BhpYqNLmL+CiIvG8DsF/XwWitHZ8ckezN9GroqL2qQwiyzpC4/zl
         E/xS8p7zSJAcM4jGGg3nyk5mzQ1IPAa7PZB1cI5CxWKsr/mZlrc7kaOaAjVu5vfQIH
         v9/DNZSOoYd4BacjRLZtz+sH2ktTqlhUcv4I0ACo=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 777FCE20386; Wed, 11 Jul 2018 15:28:45 +0200 (CEST)
Date:   Wed, 11 Jul 2018 15:28:45 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rcar-gen3-phy-usb2: Add bindings for
 r8a77990
Message-ID: <20180711132844.xky6fkuuvbppzb4d@verge.net.au>
References: <1528267348-18960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528267348-18960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 03:42:28PM +0900, Yoshihiro Shimoda wrote:
> This patch adds suuport for r8a77990 (R-Car E3).
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC45DECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D21214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="XO3r1Kcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D21214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbeIYNht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:37:49 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35805 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeIYNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:37:48 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7996325B760;
        Tue, 25 Sep 2018 17:31:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1537860693; bh=cz8k9d+x6HTmsZ8qNqALSnKiHwDX7j57O9LIEC0bUuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XO3r1Kcx2UANVT+mGeJa93QOfZjPupatTx9OyZi6Ngljht8TzBJL8VMjQ7ETPjwu+
         VjRzJXAFGarHyyJsGGmrHqieF8p8x0AvCWMYZJsxkKdYaxqYUoV4bZy+UES+VUEgqO
         k4ED8Vlb7Hih914kSJhRbZ23BFR1Ec0OyW+dIHvY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 89E27940453; Tue, 25 Sep 2018 09:31:31 +0200 (CEST)
Date:   Tue, 25 Sep 2018 09:31:31 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: rcar-gen3-phy-usb2: add no-otg-pins
 property
Message-ID: <20180925073129.umck5vyyso2ooiua@verge.net.au>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1537530804-19399-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537530804-19399-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:53:17PM +0900, Yoshihiro Shimoda wrote:
> This patch adds a new optional property "renesas,no-otg-pins" which
> a board does not provide proper otg pins.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


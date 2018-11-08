Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E976EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7E22081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kZmmq4rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7E22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeKHW4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:56:53 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:45768 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHW4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:56:53 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6C34525B769;
        Fri,  9 Nov 2018 00:21:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1541683283; bh=7TJMhX/rxsw0jvGvDx6VKHgL9MVbGGrqgixRayTzt18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZmmq4rhmNsKaaD4Qqj5l+VjWFT+fjflJJTKkVhHG/7LIq4FejTI2Tv3N9WSTBK8a
         rBvuogOa+Zsf2D7QOfhNSGzvLd0cguhVlikYr5hxKvKx0uZHhus7dgjdXrpBW1urB1
         v/dsHITtGjARHMsYGfFTDWytkFYK86+w9g5TsnfM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 5E35494048A; Thu,  8 Nov 2018 14:21:21 +0100 (CET)
Date:   Thu, 8 Nov 2018 14:21:21 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774a1
Message-ID: <20181108132121.2nrat2ecofcd3jc6@verge.net.au>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535097375-5561-5-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB1770EDC8696798A93FB7E3D2C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1770EDC8696798A93FB7E3D2C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 12:48:46PM +0000, Fabrizio Castro wrote:
> Dear All,
> 
> Who is the best person to take this patch?

I believe this one is for Vinod.

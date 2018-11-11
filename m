Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD77C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703A920872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hri0qLNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703A920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeKKTH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 14:07:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbeKKTH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 14:07:28 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F1D20818;
        Sun, 11 Nov 2018 09:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541927966;
        bh=D7m3R4yVBZ+5wgUjO5XqihsKMA0ynaYtuZLMY7W/zR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hri0qLNFMXBzIESjoIxerqoG4bglykbf+HA7CU8cYUCAlYnC5F+80f53liPOsnLtt
         bR7kvrFfjXo3LNQmc0EPt3Rwktaea0pCz3d+tfowHjqQSX1ItG0qeffV+pEooO0ap9
         qRTaf1VOIw3A2Gb5uPd+VpWH+U7s9emCBXPILcUc=
Date:   Sun, 11 Nov 2018 14:49:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Simon Horman <horms@verge.net.au>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20181111091923.GB12092@vkoul-mobl>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535097375-5561-5-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB1770EDC8696798A93FB7E3D2C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20181108132121.2nrat2ecofcd3jc6@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108132121.2nrat2ecofcd3jc6@verge.net.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-18, 14:21, Simon Horman wrote:
> On Thu, Nov 08, 2018 at 12:48:46PM +0000, Fabrizio Castro wrote:
> > Dear All,
> > 
> > Who is the best person to take this patch?
> 
> I believe this one is for Vinod.

Please resend it, it is not in my queue

-- 
~Vinod

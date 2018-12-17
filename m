Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40EFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C764217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545024684;
	bh=LLaTC+uYA+88osm+6wwbIKQx4TDGnaLpdUEC+H3TwL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=idnip6yp/ndupSaff6JvOTDUpJuaG7dXRr6M8DH6i0VKejaUkcaw8ACi2dhFwNOF3
	 w6jI1rJGxsVR7GWb2o8WAmRyJcScc5xT34147V5IpTwUbAjkieN5m/DXaX58WqG/lp
	 lnWDrOu9YnFnCfPu2hgFCEKYXiveUvWmMpRIYXcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeLQFbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:31:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbeLQFbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 00:31:23 -0500
Received: from localhost (unknown [171.61.92.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C13C92084A;
        Mon, 17 Dec 2018 05:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545024682;
        bh=LLaTC+uYA+88osm+6wwbIKQx4TDGnaLpdUEC+H3TwL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sm3ai4/IqHScUP7+qW4PdLtoYTlVQpO7W+SI/5KiRnLg3C97KRwkFn6RfldAm4jia
         X0K0Bk030usx4oQRpC+FhZLwAX95NgtsYYZ+HQTPzMTcjxMXhyfyqx1W1cqZ/Rl5i+
         lh8PKwiNo75c3ttsbdRdBcvNhnFDdyYPXAwNaD9Q=
Date:   Mon, 17 Dec 2018 11:01:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774c0
Message-ID: <20181217053113.GB2472@vkoul-mobl>
References: <1544732491-6821-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732491-6821-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-18, 20:21, Fabrizio Castro wrote:
> This patch adds bindings for the r8a774c0 (RZ/G2E).

Applied, thanks

-- 
~Vinod

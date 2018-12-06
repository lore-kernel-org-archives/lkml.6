Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5952FC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EF2214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544066472;
	bh=pNWi19ABRax4DXZa/p/28SXtUV6P7E2SCcemtsXcP80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TcwhnJMc5maw9eistSkmPAXVlv52ektaT3CzIF24swGwClrwM4fI0efAwxD+tYmYi
	 oCjwY1fOJjcpc2x60veawh7jhRavLVMeECC06CE2jIlSnHLM4nyTUG+97hWkmN3hGp
	 SB1htSMecOIfcEJKowbX7e13lTEAaz4A8Vfg7TlM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EF2214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeLFDVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:21:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbeLFDVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:21:10 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB39F2146D;
        Thu,  6 Dec 2018 03:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544066470;
        bh=pNWi19ABRax4DXZa/p/28SXtUV6P7E2SCcemtsXcP80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOYha52gZg3SzaAQTSZDzDI12PIIOAp/yzQh6w4qYCGtsUmz3XjeWeVY4v1eaN1qb
         pqvrm+PQZwOdqk58yrR+08tEVssUaKdoVL+Y1TzGaHaksWdRjsjtWfCYICLxk59a1w
         eNn0Wfso4aKSNNifLHSDv6bRSVZikZTV9JPe0dZY=
Date:   Thu, 6 Dec 2018 11:20:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dts: ls1088a: Move fsl-mc node
Message-ID: <20181206032028.GF3987@dragon>
References: <1543941180-5147-1-git-send-email-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543941180-5147-1-git-send-email-ruxandra.radulescu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:33:06PM +0000, Ioana Ciocoi Radulescu wrote:
> The fsl-mc node should sit under the soc node, so move it to
> its proper location.
> 
> Fixes: ac7c9ff741fb ("arm64: dts: ls1088a: add fsl-mc hardware resource manager node")
> 
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>

Applied both, thanks.

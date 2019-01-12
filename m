Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D048FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9483721783
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547260994;
	bh=4OR2Qjd898wbx9sACt2vql/Jl9STHa2ot64xGRxH0ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=emtO3UxC384DSUbGG2+zRnAknw6SLapUAXGQWqp/0InZadNM3yep2S3raS3TdDo1t
	 ilKsUyf6kRw1hq279rkXyf/gloWOuUg9o0c08SPbRcFD7qVeiJT38RrQ+x4R8Pi+S6
	 KWCEmS2dd20dGHg4ztbjwKcvVPLmz3yDbZajVH6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfALCnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfALCnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:43:13 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DE882084E;
        Sat, 12 Jan 2019 02:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547260992;
        bh=4OR2Qjd898wbx9sACt2vql/Jl9STHa2ot64xGRxH0ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uuwlfe2OnFsnakvI14MVQcaj1slDQCZF5Cy1N3kHN84B3bd0e9ESy6XqS1O1bjjdp
         GUrCk6ZUKg3eXPknKQMvoOXLwvC0JN6Y5OE7SeBG8/KrhwK29b/TSdAqeJIXEaqdDW
         gs9JmQYK6x7d7FHqR7bEL82ufDtmnSaD/rpw0gOw=
Date:   Sat, 12 Jan 2019 10:42:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dts: lx2160a: Add fsl-mc node
Message-ID: <20190112024257.GN32649@dragon>
References: <1545325306-1681-1-git-send-email-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545325306-1681-1-git-send-email-ruxandra.radulescu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 05:02:03PM +0000, Ioana Ciocoi Radulescu wrote:
> Add the fsl-mc node in the LX2160A device tree.
> 
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>

Applied both, thanks.

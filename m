Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A64DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75C12184B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547257353;
	bh=dyNuexrjM/jcTJRKuwcvi8ak3GIb40wcfbooRxWDuiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FJASB6BtCj+ybplWMO9OkkFeX4Zlz4gZwH9dVH/RDL3DQ2JaJWONAq5v9U5BJ2a4L
	 UlyQf2UahL6P/gBr0Pg6nFA/IKw1ni1+ta2B7oQH42RCI9RxBwwcEFPLFDiHOqnPlQ
	 7oKG8dqRmn0fl+gN7LdkbNpyjGxhflXtD/5cuRAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfALBmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfALBma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:42:30 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C304420870;
        Sat, 12 Jan 2019 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547257350;
        bh=dyNuexrjM/jcTJRKuwcvi8ak3GIb40wcfbooRxWDuiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjkmuGfKuwknVAq0YnHAzYHgsVuaJcOmhSsfIYCLoj+ALSbisKlMhql6oPjYtVGRx
         g19kXf30yumJxCvTwdYy38aki1qDHew6N/kZsSMzyub6heVZzBEVROI5MPupAtxJDp
         0H/yxt2W/UpuTeMmEhqnyw5zb4oHQOkJbLm4MoHw=
Date:   Sat, 12 Jan 2019 09:42:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: layerscape: Add
 incr-burst-type-adjustment property to USB3 node
Message-ID: <20190112014214.GK32649@dragon>
References: <20181219094109.3836-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219094109.3836-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 05:41:08PM +0800, Ran Wang wrote:
> Add this property to all layerscape platforms to improve USB read write performance.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Applied both, thanks.

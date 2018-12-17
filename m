Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837CFC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC0A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbeLQJ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:26:38 -0500
Received: from 8bytes.org ([81.169.241.247]:54510 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeLQJ0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:26:37 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 684643F7; Mon, 17 Dec 2018 10:26:36 +0100 (CET)
Date:   Mon, 17 Dec 2018 10:26:35 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Hook up r8a774c0 DT matching code
Message-ID: <20181217092634.i67xgmyw2wnbgfwa@8bytes.org>
References: <1544732564-7185-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732564-7185-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:22:44PM +0000, Fabrizio Castro wrote:
> Support RZ/G2E (a.k.a. R8A774C0) IPMMU.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

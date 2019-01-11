Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD80BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8047F2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbfAKL0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:26:02 -0500
Received: from 8bytes.org ([81.169.241.247]:56868 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbfAKL0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:26:02 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 17577434; Fri, 11 Jan 2019 12:26:00 +0100 (CET)
Date:   Fri, 11 Jan 2019 12:25:59 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] iommu/msm: reduce indentation
Message-ID: <20190111112559.gvd2swdgnypqxhmk@8bytes.org>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
 <1546185195-25676-9-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546185195-25676-9-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 04:53:15PM +0100, Julia Lawall wrote:
> Delete tab aligning a statement with the right hand side of a
> preceding assignment rather than the left hand side.
> 
> Found with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied, thanks.

Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E86AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A39520867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ARTGE0qC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A39520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbeIYSTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:19:42 -0400
Received: from 8bytes.org ([81.169.241.247]:35102 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbeIYSTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:19:42 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A6055702; Tue, 25 Sep 2018 14:12:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537877545; bh=XDM5suq8fspx4uOg4RmfeKZUqEb5O8kSH7nLahrJfTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARTGE0qCBzv54lryZoCc28Q9ISd6S5XqVB4M6++10manTkvUsJShgNuF/l0kgsxQq
         vg2lCfjCl1gPAHtv2duEeZbuEoS4MGtHB4fsx/08OUT12ifKf/m3P7e6U5XPbqOjPt
         Z66O5u0BIP8glLb6rgJ+nXM6sI1JVAyGo3jlbl4vwYyle8WuHDzb3UNRLGdbfE2mmN
         Z39K92gdKvyn525BGZkzN873jAfceWD5wngLIE8AsRisiLUkVO8CwCiqEx+08pwZiA
         souds3RtSbLPq+BoOYo9G8H8kBl92w8S7ne2jc4jOzWYyVololuGdnava9SllRcJz0
         cU+3/F/93EOKw==
Date:   Tue, 25 Sep 2018 14:12:24 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Colin King <colin.king@canonical.com>
Cc:     iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/fsl: fix spelling mistake pci_endpt_partioning ->
 pci_endpt_partitioning
Message-ID: <20180925121224.36wxga5vm7ebqwir@8bytes.org>
References: <20180911122832.32383-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911122832.32383-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:28:32PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in variable name
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.


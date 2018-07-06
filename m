Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44641C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED25723FCF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="NqP9Ni7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED25723FCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeGFMHL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:07:11 -0400
Received: from 8bytes.org ([81.169.241.247]:53492 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753672AbeGFMHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:07:10 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 232181F0; Fri,  6 Jul 2018 14:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530878824; bh=74XubT+2Bx5WBeQ4IqaPpKJQdtH8jsQRsCSIHrPvIhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqP9Ni7aPF6A3fWhsb5uztdvF9Jmq5ryVpQKfw7qVE25N3hV+Nr5Osm5HvYCY/N5L
         TrbDxeHpgAT+X3AVNNM/ta5AKZZ52NQvBAFdSUL/H8xIFxyAoeeNmTH2arqUqjLHQg
         Sv5k4Zgs8BMmQMAWm5sktNSoqb9doeDHvyQPhqDPr54Sa9HgZmr8o9IXvk5h/rXgYf
         2d/oqVfMk+btqnt9qlxBDuzCnPDFt1v3EtulgYm9xF5SeiUEjHn9GxrWPCW1gKTbSJ
         E6HwtjjTACzKXhwQOedTg4Y/jDS/OhzhqqgbXWM+hhlQngQgyw2RwlwYEsO7LYzIZu
         bATKWDLy/aqEQ==
Date:   Fri, 6 Jul 2018 14:06:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Gary R Hook <gary.hook@amd.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/2] Base enablement of IOMMU debugfs support
Message-ID: <20180706120659.rg66wjr73wepwzjl@8bytes.org>
References: <152883965482.1936.13657625103232933481.stgit@taos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152883965482.1936.13657625103232933481.stgit@taos>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 04:41:12PM -0500, Gary R Hook wrote:
> Gary R Hook (2):
>       iommu - Enable debugfs exposure of IOMMU driver internals
>       iommu/amd: Add basic debugfs infrastructure for AMD IOMMU

Applied, thanks Gary.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EZ1ZOLM2Gls4cAAAmS7hNA
	; Fri, 08 Jun 2018 07:57:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 52A6D607DC; Fri,  8 Jun 2018 07:57:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="PJhrRF3z"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B3CAB606FA;
	Fri,  8 Jun 2018 07:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3CAB606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeFHH5P (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:57:15 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:56456 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeFHH5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:57:13 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id AC3E825B7E1;
        Fri,  8 Jun 2018 17:57:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1528444632; bh=8s1r1kjHMHyyu+HBe1Uck/173P1h1pX32DjeoM/vW1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJhrRF3zoIu53y1W8dGRnka2vScln8B+q8564k2UyvRgjiBCD2u9jO+u4qASgbKXF
         L98hf3AaqpXvC1k0tmI0Rr1gExq0T4xAODzJHGhpYo2ODdwGZixY5x66IREHhoU5pM
         qt7gRMpT0lWfU+GK5QaUB209FJgX4l/4RblptGHs=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 690AB940527; Fri,  8 Jun 2018 09:57:09 +0200 (CEST)
Date: Fri, 8 Jun 2018 09:57:09 +0200
From: Simon Horman <horms@verge.net.au>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: geert+renesas@glider.be, jroedel@suse.de, magnus.damm@gmail.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iommu/shmobile: Remove unused
 include/linux/platform_data/sh_ipmmu.h header
Message-ID: <20180608075709.fjk5ohrxz5ukrcdh@verge.net.au>
References: <1528400696-32609-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528400696-32609-1-git-send-email-clabbe@baylibre.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 07:44:56PM +0000, Corentin Labbe wrote:
> include/linux/platform_data/sh_ipmmu.h is unused since commit ae50dc4874c5 ("iommu/shmobile: Remove unused Renesas IPMMU/IPMMUI")
> Let's remove it.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

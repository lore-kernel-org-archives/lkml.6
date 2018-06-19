Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D9BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1ABB208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db8XbxXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ABB208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964963AbeFSDK3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937096AbeFSDK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:10:28 -0400
Received: from dragon (unknown [45.56.152.47])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26C7320693;
        Tue, 19 Jun 2018 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529377827;
        bh=vCNLLTXhRg9+r+kvnk5R959jhvx87pjXhIrDxB7xCHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Db8XbxXaB37+sxYdLxtskh6arC0ccmAQfboREWUReeN1Q5U86XFMmzqeCwvPOHeVr
         WzIQihTIAd94qrZWLyLJj6L+MHTOCOzU9vI/mL3x8KJLXUNaPuqvnMvuRBxRCPOpEA
         /myQd3a62cnHer+atkABBudz8ug2Pyif4C3pmNMk=
Date:   Tue, 19 Jun 2018 11:09:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: freescale: Update to use SPDX identifiers
Message-ID: <20180619030931.GD16091@dragon>
References: <1528828122-9276-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528828122-9276-1-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 01:28:42PM -0500, Li Yang wrote:
> Replace license text with corresponding SPDX identifiers and update the
> format of existing SPDX identifiers to follow the new guideline
> Documentation/process/license-rules.rst.
> 
> Note that some of the files mentioned X11 license previously but the
> license text actually matches MIT license.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks.

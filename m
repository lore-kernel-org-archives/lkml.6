Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60818C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBA02086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547812686;
	bh=NKR55ThJJiCmkl0muRUs79kvWNd8vOraK9CNFEv95ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FLNmH2U7NfF9bl9Tk0E36zKHwIhFb2WlTLAg/dQ4jZCL4NDadz+spHC9R0kNoKPsA
	 I3UZPxlA1KlzfoLG5hC5GekcG0ztwrTGnEv8Eig72KdpiM6bCPs9vpdiVfHqBMfeeI
	 max/LJipeQzCM1bV9hC/Vuckd4+ffkUYzVJ9TynQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfARL6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:58:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfARL6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:58:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B081D2086D;
        Fri, 18 Jan 2019 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547812683;
        bh=NKR55ThJJiCmkl0muRUs79kvWNd8vOraK9CNFEv95ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNx4yys1IfMpP8Tm12V2cciPic1TaR9zzwHoeVaqrxT22ODm/wFaOqM8vVWt1/qnb
         53WrIIHsrOWRDJw3Eyss02M4X23MRIbbNyAJ2NV6Ckk429niNrjqOMm4twVQevK9Hb
         ZfcCJK9OfmSlnsL2oTdomTscozhu0VwIyLxtsj4o=
Date:   Fri, 18 Jan 2019 12:58:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: For 5.0 -rc
Message-ID: <20190118115800.GA20431@kroah.com>
References: <20190118092812.26148-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118092812.26148-1-kishon@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:58:12PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the PHY pull request for 5.0 -rc below.
> 
> It fixes a build issue in ahci platform driver caused due to a patch
> merged in libahci_platform.c before a dependent patch merged in PHY.
> The ahci platform driver patch was merged after -rc1.
> 
> Others are relatively minor fixes seen only on error scenarios. Please
> find the complete list of changes in the tag message below.
> 
> Let me know if I have to make any modifications.

Now pulled in, thanks.

greg k-h

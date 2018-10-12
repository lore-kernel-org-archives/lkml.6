Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F631C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1283B2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTsJh7yK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1283B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeJLSn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbeJLSn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:43:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D36502077C;
        Fri, 12 Oct 2018 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539342720;
        bh=0g3lngiWnLCTsCbP+62IOE5hyXYTGgHDiFxkCHEDhrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTsJh7yKkBq6rOx+20nEHOYmsImOYadzEBSv5VneeOspphTeqiS2IJBexwFoAjy/t
         A25ujzPLOhrb3JWC7bqRDOw0tvKjwRzv7GdA6rSwzfCWknZleJHOAs5LC6wguJq/gq
         pEY9OUMzngIBNnVpVI5zdQiX/7zkCt4cbGL1/QB8=
Date:   Fri, 12 Oct 2018 13:11:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Brian Norris <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] mtd: Fix for 4.19-rc8
Message-ID: <20181012111157.GC6536@kroah.com>
References: <20181012092555.7e92d996@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012092555.7e92d996@bbrezillon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 09:25:55AM +0200, Boris Brezillon wrote:
> Hello Greg,
> 
> Here is a PR containing a fix for a bug introduced in 4.19-rc1.
> 
> Regards,
> 
> Boris
> 
> The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:
> 
>   Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-4.19-rc8

Now merged, thanks.

greg k-h


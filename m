Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FD6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18FE204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547565946;
	bh=8oSjczKqQVBCstlTvPIavq0sAfA16bYw1X7Wx33HQDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J/D126cJx2id4RBIocvJ1inynNfPek7TA+rI9+G8xphtJ0fvp1QkXmQIEbug7gmVK
	 HtSvtYTyIq2d2Ff5ojAxahkRRHE4C//6pI+gUv3TyjFSH9YYauuLcBrFsWUGeq94Oj
	 9DBFBLES/Vkjk16V2O0QIV89AS5xCzDopz83L1bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfAOPZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:25:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfAOPZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:25:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 274CD204FD;
        Tue, 15 Jan 2019 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547565943;
        bh=8oSjczKqQVBCstlTvPIavq0sAfA16bYw1X7Wx33HQDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q43DP4to1e+mqhEmk5ZJEK9Mf+79GV3sZRskfFc+t0RXBccqBdgQAreybE43Gjp4e
         ePEv8K4T2E7FqzaomyNMZmgOwavsGVU7Nygww2LQ2b2nIFu0wU4Wg9ifA+HSLKHdGp
         aQAoGUIuflFG/ztegK1PB+vN7ZOpn5pGjxsOP+Tw=
Date:   Tue, 15 Jan 2019 16:25:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: rtl8188eu: add spaces around operators in
 os_intfs.c
Message-ID: <20190115152541.GB4323@kroah.com>
References: <20190115082402.8519-1-straube.linux@gmail.com>
 <20190115082402.8519-3-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115082402.8519-3-straube.linux@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:24:02AM +0100, Michael Straube wrote:
> Add spaces around '+', '<<' and '*' to follow kernel coding style.
> Reported by checkpatch.
> ---
>  drivers/staging/rtl8188eu/os_dep/os_intfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

No signed-off-by :(

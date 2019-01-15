Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE898204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547565937;
	bh=Ch5Ti5yanDmu1cAdwTPmIRDJ8FadwYikBJBUs+A3ISY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NcRyAPaEDSxhLWkNr5AsBT6Y8duFssT+pLYLBIhVSFWBvRHjZWSaTFNEQKfHuSecx
	 klS3C+i+8CZ1fNd+IyQEt9aMIEgni49SEQdCEsUpp7L8LgVaI4wfj6xHa0wsddnPxG
	 G22FmN70sG33dcYVIX4ws3rYd2eBRiOzkmRQxsI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfAOPZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:25:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfAOPZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:25:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15615204FD;
        Tue, 15 Jan 2019 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547565935;
        bh=Ch5Ti5yanDmu1cAdwTPmIRDJ8FadwYikBJBUs+A3ISY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eN3XBxfuQFL6P8+p6GkaMPD0Li4/1J4v5aBifzc/PojhVPCO9jfdqHKScQ2xITkQs
         kpk8tgwcZx8JFXeLL44a43F1ujkGGTQMLNEt3rTymxsvbSdJlCsF82vHEiIDXvDku5
         VEwqcWNGsyZ+1FxB3hLhwXEeHAkpyn7ye+S+yhOA=
Date:   Tue, 15 Jan 2019 16:25:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: rtl8188eu: cleanup declarations in
 os_intfs.c
Message-ID: <20190115152533.GA4323@kroah.com>
References: <20190115082402.8519-1-straube.linux@gmail.com>
 <20190115082402.8519-2-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115082402.8519-2-straube.linux@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:24:01AM +0100, Michael Straube wrote:
> Replace tabs with spaces and/or remove extra spaces in declarations.
> ---
>  drivers/staging/rtl8188eu/os_dep/os_intfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

No signed off by :(

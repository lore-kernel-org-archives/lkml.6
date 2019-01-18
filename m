Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE627C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7E620883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547815758;
	bh=WiSWEI1ThiceftT/2o/3a/2A/OCjN9YGs0YwDCcQABM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NtmM/ri0qkpBwCwW0mGS7mLLE57Ui99UagrfIW1sBkLgbAxIT+LrgRg5BiX5DTjCM
	 Na5KeaZde9JbzJD/ml9ykuIwI8P9iw3JwQGvjrgSpuohXACOMieGIerYASUGv+Fm7j
	 QUkb7/buhrNQ6doXtZat9X/yS4QEb05GWv50XyDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfARMtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbfARMtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:49:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFBF82086D;
        Fri, 18 Jan 2019 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547815756;
        bh=WiSWEI1ThiceftT/2o/3a/2A/OCjN9YGs0YwDCcQABM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udsYHhX/l48pKJw9zeFPZJmNTiXqmkt35v6aOhuls3IdO7fu9p/D/rcrjATbtrMyk
         Lg4H5cE9mkgo3EtRFw9rDz+XNlEBu4fe9PGetJA3PRoIgdHrOLFUb1sRG9ywpPtSRU
         oX29bRALI0sPSe7Tun1wrCrpPmPkdx9LY4KUwP5E=
Date:   Fri, 18 Jan 2019 13:49:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] assorted console/vt/vcs fixes
Message-ID: <20190118124913.GA12339@kroah.com>
References: <20190109035504.8413-1-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109035504.8413-1-nicolas.pitre@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 10:54:58PM -0500, Nicolas Pitre wrote:
> Hello Greg,
> 
> Here's a few patches fixing various issues. The first 2 are most
> certainly stable material. I don't know if the other issues are serious enough to be stable worthy though.
> Please feel free to tag them as such if so.

Thanks for all of these, now queued up.

greg k-h

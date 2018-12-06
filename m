Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0AEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A426220892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107885;
	bh=dzXQ5YdpbTbZ2aEH0bHdoqFfilw/d9auHsHNnijy7T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ntqww0TWKSMbdEXS+tJomos9QevHJcN0YIHxQbKeVdcpL4YrlIwPdV57vKCjxYoKm
	 mexqcOg3uQP5w1GqAJ/OxpZRaTMzba8pplRWTmuLR9Sbz5zKuISM0GshMaLvDTIuJS
	 VqPVcvKRVgPxoiBUExQBAxXyws7HDeSNGctGIQu4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A426220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeLFOvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeLFOvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:51:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B31AC20850;
        Thu,  6 Dec 2018 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107882;
        bh=dzXQ5YdpbTbZ2aEH0bHdoqFfilw/d9auHsHNnijy7T8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+5+pYIlXcRUo28D9i0Gp597zq1REJ4N93dC6fBHL62SocuZz8HbbYMLAuOJjBan+
         X70d0mE5S1jLbSF76mjZwL1djms+ARsg6Y9uay8NppBtAyp/8AqhQ6ZSiqOc6rhiRf
         r0cpWgAnykd2BXByZN1KwsuigL+C1rbYHOPQpd7o=
Date:   Thu, 6 Dec 2018 15:49:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] nvmem: patches for 4.21
Message-ID: <20181206144911.GA15302@kroah.com>
References: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
 <CAMRc=MfN=N9i372QBjHfAT-rR7t6ZLL1r-ZSM3LkF+sA4CK++w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfN=N9i372QBjHfAT-rR7t6ZLL1r-ZSM3LkF+sA4CK++w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:11:30PM +0100, Bartosz Golaszewski wrote:
> pt., 30 lis 2018 o 12:53 Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> napisał(a):
> >
> > Hi Greg,
> >
> > This patchset adds support to
> >         - new meson-efuse peripheral clock
> >         - add type attribute
> >         - add new config option to ignore dt node to scan cells.
> >
> > Can you please pick them up for 4.21.
> >
> 
> Greg,
> 
> could you also pick up this one:
> https://patchwork.kernel.org/patch/10680701/ together with my nvmem
> patch from this series?

Ok, now picked up, thanks.

greg k-h

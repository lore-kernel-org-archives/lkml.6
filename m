Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5AC2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544534741;
	bh=HGD7s5gUAuMGPYk6SXqx80kY8J7s99QTZZsA6eqp+IA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r+GlpKFsIp94MKwYwPcXLbKPA8XPJhhg/1N1zhVQAYei+MsB8ZemUockn3vlC9x4A
	 aqu1/ww+atKK1DRjBF2JIXK445ZXTmXbRbo6wOsjWbPuYqq81ss6nFAPO1CiUFsGZx
	 w4e20bpsaGSf/BuPHn1rzBJmVQZt0dx8hZzpX+S0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5AC2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeLKNZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:25:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbeLKNZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:25:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74ABF2082F;
        Tue, 11 Dec 2018 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544534739;
        bh=HGD7s5gUAuMGPYk6SXqx80kY8J7s99QTZZsA6eqp+IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAkdp/n/OtmJRxO/nplIX0ig+GfcbuRf8/ciJNHecjjtffth7N+rl1h6Kjrg9e7+5
         C27LUMFN/UrlNFusPAn1q2fILi8rzlOVrp9MZDVprLWLIiidPzodpNvsEZ/VC2pbrc
         m8KV2XjTMloVR1qryPFQCOLPp+2rGuLRMXvWBzlw=
Date:   Tue, 11 Dec 2018 14:25:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v4.21
Message-ID: <20181211132527.GA6246@kroah.com>
References: <CGME20181211052721epcas2p1f5a54f0b24fa8f654b379be8a43db644@epcas2p1.samsung.com>
 <5C0F4AB9.2090304@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C0F4AB9.2090304@samsung.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 02:27:21PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v4.21. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-4.21

Pulled and pushed out, thanks.

greg k-h

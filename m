Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F35C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AB121A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550213832;
	bh=Q9VvW7REZ5s+0H4z8rmYIEbtLkrIV9ExbnL9J8zmDvE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=pWMMKuHZ2gK7h0qAAgGIxxYgdj0FnHWjuSkZvRmbhn2M6enELvPVhSlZZUo2M2RqD
	 9lc/WQ5/8HxV5PFWQgN57nd1vF+DPePzB/Rd8E3K1UsPdFKnPPKKlOBDyOorcEwfay
	 9LdUyqoJw2212AwdygNS7RHDtYZg38KbO0mt8I2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbfBOG5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:57:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfBOG5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 01:57:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B17A21927;
        Fri, 15 Feb 2019 06:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550213820;
        bh=Q9VvW7REZ5s+0H4z8rmYIEbtLkrIV9ExbnL9J8zmDvE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=RS07stijcaKMwbqWXYk/kbridXo18TT7pQ5WNypohOkngOEz3/MmJ6pmfPL8yw7KS
         S9KFD8pX8eutYRaPfUyjdJmy1tyYg3KeenBda4Hj9KNOFxM+WsuZgSb1s+tkC7h/dB
         baZ9Z73IjvfPbPFcvOTQ6WC/jxRXNenJmtl9YwNE=
Date:   Fri, 15 Feb 2019 07:56:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.20 00/50] 4.20.9-stable review
Message-ID: <20190215065648.GC14473@kroah.com>
References: <20190213183655.747168774@linuxfoundation.org>
 <20190214165242.34kewf65sdvfws6m@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190214165242.34kewf65sdvfws6m@xps.therub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:52:42AM -0600, Dan Rue wrote:
> On Wed, Feb 13, 2019 at 07:38:05PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.9 release.
> > There are 50 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Feb 15 18:36:30 UTC 2019.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Great, thanks for testing all of these and letting me know.

greg k-h

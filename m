Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8616BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E23208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4+ffRy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E23208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965755AbeFOLIN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965708AbeFOLIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:08:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F323208D7;
        Fri, 15 Jun 2018 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529060892;
        bh=N2PykYXajw/bRI8Y7w8WMekKDAPHNMVzDC3GAXw5H7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4+ffRy131QIdCPw3ECrm242uqCQ7OKmw7lb56vIIZ0dHSGqHIwavV8gnAEh1EGP8
         aNXhIb9qCADpCjUXcwUGBGVLfN2qB08bYJQtEA005V/gMMgSd4qcphzs36o8bTPqKE
         bltc1+VYoDRUD42xaUdTiBDUkWwvfHav8pFP0qck=
Date:   Fri, 15 Jun 2018 13:07:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Janani Sankara Babu <jananis37@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Rene Hickersberger <Rene.Hickersberger@gmx.at>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] Staging:rtl8192e Replace function names by using
 __func__ identifier
Message-ID: <20180615110749.GA14855@kroah.com>
References: <1528432379-9605-1-git-send-email-jananis37@gmail.com>
 <CAHp75VfKBkZ3znZn4YQPyOCrzT8aKZ0OAFTP2uErhoEgD13Z+A@mail.gmail.com>
 <CACHTOGocFR_JVOjS-uo1-nehwUJ5vC6cd1+jcWsu2gfdgLFrOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACHTOGocFR_JVOjS-uo1-nehwUJ5vC6cd1+jcWsu2gfdgLFrOA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 02:22:59AM -0400, Janani Sankara Babu wrote:
> Sorry , Kindly ignore this patch.

I'm dropping this whole series as I can not tell what should, and what
should not, be applied.

Please fix them all up and resend, as a properly threaded patch series.

thanks,

greg k-h

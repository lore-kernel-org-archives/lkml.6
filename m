Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDD5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A63222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549996686;
	bh=iliBRNrqgU77Ltm6Wzk7rMIn+R5efGUyLJg2fAzIFkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oL3K1Wm6naGbLs/9AnmWuCPlBIvcygfyKGpn3Ag2H9Hz6d+YSWbNYhsIxSq+x74LH
	 pv/TE1kEWZzIOznxOuzhw779YHwe7Z7tCi/wCjHWeWzyrC7vmxrrFjkwuLFQFIE8DQ
	 TZSzvOvC0fglQ9HqtxF02V/2EgqS0vGgIwcH65Sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbfBLSiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfBLSiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:38:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B6A42190B;
        Tue, 12 Feb 2019 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549996684;
        bh=iliBRNrqgU77Ltm6Wzk7rMIn+R5efGUyLJg2fAzIFkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXuoNUyZNaW7V+7bPKLg8FHiu9fRUuHBpn8d0H9bG3I6riC8OXC+r/nRXRQ6smX68
         wrhb2cCu11M0ad+hoJOGNzJk32I37UMVojhaRdpBZ+y9U+pjQURMOsfvpmLF3rzCcz
         qqqVYKySg9GDL3HDdi+TVGVRTkgIZ5n/fn6kp0Q0=
Date:   Tue, 12 Feb 2019 19:38:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/352] 4.20.8-stable review
Message-ID: <20190212183802.GC14892@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <6ed3a3b3-1bed-96ba-d773-167059fa27f2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed3a3b3-1bed-96ba-d773-167059fa27f2@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 08:41:50AM -0800, Guenter Roeck wrote:
> On 2/11/19 6:13 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.8 release.
> > There are 352 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 13 14:17:03 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 343 pass: 343 fail: 0

Thanks for testing all of these and letting me know.

greg k-h

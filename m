Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD20C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50D4208A2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50D4208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeHRSad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:30:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRSad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:30:33 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5036C3EE;
        Sat, 18 Aug 2018 15:22:29 +0000 (UTC)
Date:   Sat, 18 Aug 2018 17:22:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.18 00/22] 4.18.2-stable review
Message-ID: <20180818152226.GD12696@kroah.com>
References: <20180816171556.502583508@linuxfoundation.org>
 <20180818142107.kaob63iv6kpd3vtn@mobile.celeiro.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180818142107.kaob63iv6kpd3vtn@mobile.celeiro.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 11:21:07AM -0300, Rafael David Tinoco wrote:
> On Thu, Aug 16, 2018 at 08:45:16PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.2 release.
> > There are 22 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Aug 18 17:15:44 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Thanks for testing all of these and letting me know.

greg k-h

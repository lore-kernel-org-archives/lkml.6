Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51925C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095E92086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544600044;
	bh=7VORMG7CDGBsQRlkDVDPYXf9zAXoiFPAIQE4zKoQ4uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XKnGooMly4ySpxXXlAvL4dDkLl1Bdb+BBk1lTWUMm/TtY06JTlFz6U3Ji3tHvDAeB
	 e42LxhwMw8rQ+rGexh4JJEzoqOuqAJyw16kqr0JrQigrKQTHkRSpkOma0Y77BgALdP
	 XsIZQCypC3TExfNkFSMojo6EPAveMNtamUsq4X5c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095E92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeLLHeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:34:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeLLHeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:34:02 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF172084E;
        Wed, 12 Dec 2018 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544600042;
        bh=7VORMG7CDGBsQRlkDVDPYXf9zAXoiFPAIQE4zKoQ4uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3FyrcSK7G6y2MeU3a1PtFBcWinJSB+3/WaY3i9H6QbTTxRBxZjSKYPRX3ZBO2r9K
         kkdXrCCv91dOvvhGIkf/6Yd5iiqHlHx9NXumXFt3mlfCDCKqUDxL/U73TgyXdKMtwA
         bSAIG4vPDcgg6HVPCH+Up/lKroL7h0NFYr3XRNEo=
Date:   Wed, 12 Dec 2018 15:33:56 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: working toolchain for c-sky
Message-ID: <20181212073356.GA6864@guoren-Inspiron-7460>
References: <20181211195715.GA32516@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211195715.GA32516@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:57:15AM -0800, Guenter Roeck wrote:
> Hi,
> 
> can someone point me to a working c-sky toolchain ?
> 
> I tried several from https://github.com/c-sky/tools/, but they all fail
> to build csky:defconfig with various error messages.

Try this:
https://gitlab.com/c-sky/buildroot/-/jobs/131973812/artifacts/browse/output/images/

See readme.txt for run.

Best Regards
 Guo Ren

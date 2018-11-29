Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99291C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5564D2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajMYdn7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5564D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeK3JRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeK3JRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:17:46 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1FF2145D;
        Thu, 29 Nov 2018 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543529449;
        bh=BcJdR5rhcDOQqjbtHyqK32dMYcUidizEjltZweVoYPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ajMYdn7oZCNFT2bIfXRtjvvhfKR7mvbZ4mISNoG3t3b9b68YSO2mQt2bYjB3q3Rlo
         P8t4XnkgQTtkc46L3YmXsX8BoANC8WiYqbaumpaGCPrtDk2EkDti45D7FoncuKaDiS
         ESuQ0vQeetmPwY2WTFJD5zF48F2ZNSxK95UFihMM=
Date:   Fri, 30 Nov 2018 07:10:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Fix invalid SPDX identifiers
Message-Id: <20181130071046.45bd7fd84fedeafb09c0e1df@kernel.org>
In-Reply-To: <b69b7168-330f-28b5-ec28-8ce91f63dd09@kernel.org>
References: <alpine.DEB.2.21.1811121108000.14703@nanos.tec.linutronix.de>
        <alpine.DEB.2.21.1811292220010.1657@nanos.tec.linutronix.de>
        <b69b7168-330f-28b5-ec28-8ce91f63dd09@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 14:54:16 -0700
shuah <shuah@kernel.org> wrote:

> On 11/29/18 2:20 PM, Thomas Gleixner wrote:
> > On Mon, 12 Nov 2018, Thomas Gleixner wrote:
> > 
> > Polite reminder....
> 
> Thanks for the reminder.
> 
> > 
> >> While GPL2.0 looks about right, the correct and valid identifiers for GPL v2
> >> only code are 'GPL-2.0' or 'GPL-2.0-only'.
> >>
> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> >> Cc: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> >>
> 
> Hi Masami,
> 
> I am pulling this in for 4.21-rc1.

Oops, I missed it. 

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>

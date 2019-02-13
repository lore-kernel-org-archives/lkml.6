Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BA3C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7E6222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550079950;
	bh=0ZusrYp5tuSg1R/HEMwBvgk8ub4mfL8T4XG+nwzZEDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x6LlYigxSOcbh8Cet9pXtRbSWEQfISqTdSv9WAgbn9PC6YqkocFtRy4h1iaivsau0
	 Xy7Aq2Wq0zDoH56H0KlRteYy+Xd2DdZ4i3ycbD+fqT9fG7yReGm62dYINOka5CD+H/
	 20bYwoG0IB7W98bubSgMQIVtgud1YtZ3sWkz3Mew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404319AbfBMRpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:45:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbfBMRpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:45:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A0112190A;
        Wed, 13 Feb 2019 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550079948;
        bh=0ZusrYp5tuSg1R/HEMwBvgk8ub4mfL8T4XG+nwzZEDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGBak5tLGIK0ST0esDOPvcz1sa29cW0zAmypF/X+e1L2SA4/P9fDMv7dotcjL61dZ
         q7HCuH3fLDtw2fzbeEaosBDbrUv8x2hrb6ScSx9u2/nZqTLYgTuMrkMvOv4yzcbokl
         rHYIUPzHcvygzCuRX3s2NVcrIg5oleOwPaZRye7E=
Date:   Wed, 13 Feb 2019 18:45:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 4.14 perf test patches
Message-ID: <20190213174545.GA9097@kroah.com>
References: <68c69f70bc7b524731c70f1f4fde40c5b16688ef.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c69f70bc7b524731c70f1f4fde40c5b16688ef.camel@nokia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:38:14PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> Hi,
> 
> Can you pick these patches to 4.14.y?
> These fix some "perf test" errors seen when running in VM.
> 
> commit 10836d9f9ac63d40ccfa756f871ce4ed51ae3b52
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Mon Jul 3 16:50:30 2017 +0200
> 
>     perf tests attr: Fix task term values
> 
> commit f6a9820d572bd8384d982357cbad214b3a6c04bb
> Author: Jiri Olsa <jolsa@redhat.com>
> Date:   Thu Sep 28 18:06:33 2017 +0200
> 
>     perf tests attr: Fix group stat tests
> 
> commit 692f5a22cd284bb8233a38e3ed86881d2d9c89d4
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Mon Oct 9 15:07:12 2017 +0200
> 
>     perf tests attr: Make hw events optional
> 

Sure, now queued up, thanks.

greg k-h

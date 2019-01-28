Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC07C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6EE21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548704067;
	bh=9iFgeScsgv8VHJu+YuxBHTUp+lUwz1ZlURXd8z9qvi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vXBnZB8Bdt2GTF9Wcems+eICFNhGiqF08gosW+lcgLWVdZM8l593Iwakkgu/HmCN8
	 wWyD+GdiY6uBrSnJrYZbPMJVO+ynY9E4ZOJocO6fl71GGGk2rTHVEACWoy2k09qivc
	 89Ud3bFuJxJpGDo+7LGHnC+lDdSRBxCqe0j3fH7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfA1TeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfA1TeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:34:24 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8DF2171F;
        Mon, 28 Jan 2019 19:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548704064;
        bh=9iFgeScsgv8VHJu+YuxBHTUp+lUwz1ZlURXd8z9qvi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4sG9i+7iasUFt5w0dSMm52KDS5M4TwwKSn9IpOHnhXtcE4Ky3O4xhkWL+v7AJXl8
         X49jOuWfik6iFWJsUTaUiC7Y3S3ihAZ4cCtvhJWQ7nNM7TG6wAQiL2Uy3YuElD66kP
         43HcDm0vvCcRECF2f/kTrF+1hd2u1N4VvkS+k2O0=
Date:   Mon, 28 Jan 2019 14:34:22 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "milian.wolff@kdab.com" <milian.wolff@kdab.com>,
        "jpmv27@aim.com" <jpmv27@aim.com>
Subject: Re: 4.14 perf unwind fixes
Message-ID: <20190128193422.GJ3973@sasha-vm>
References: <e975fbaa1bf8449038e422d7380abc4de4a36a8d.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e975fbaa1bf8449038e422d7380abc4de4a36a8d.camel@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:57:04PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
>Hi Greg,
>
>Can you please pick these two upstream patches to 4.14?
>They fix broken perf unwinding for me.
>
>
>commit 3d20c6246690219881786de10d2dda93f616d0ac
>Author: Martin Vuille <
>jpmv27@aim.com>
>Date:   Sun Feb 11 16:24:20 2018 -0500
>
>    perf unwind: Unwind with libdw doesn't take symfs into account
>
>
>commit 1fe627da30331024f453faef04d500079b901107
>Author: Milian Wolff <
>milian.wolff@kdab.com>
>Date:   Mon Oct 29 15:16:44 2018 +0100
>
>    perf unwind: Take pgoff into account when reporting elf to libdwfl

I've queued these for 4.14 and older. Thank you.

--
Thanks,
Sasha

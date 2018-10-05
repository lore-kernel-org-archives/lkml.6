Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8F4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A2521473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHQ30Iw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A2521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeJFEYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbeJFEYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:24:00 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17ECD206B2;
        Fri,  5 Oct 2018 21:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538774608;
        bh=+5HbPWYGiAZs50u7t4agVDW9sALTqTvafSGINMvZmkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHQ30Iw4oS+oC7u90Tz8qOGHofxPzyhMobZH0Q650oLos0PjmlHm7oXFgP5cen7lk
         HCXdlI23tT8SpQaLBqtKOTDXYv42eYLkVMcLyQ+dC2y254Wu3PjCl7DaH1nV3HVXrE
         E81nf7URXnT1W5io0cmxQs7Mu5qCwcUtBTeU2aFI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id C5FA4141DDC; Fri,  5 Oct 2018 18:23:24 -0300 (-03)
Date:   Fri, 5 Oct 2018 18:23:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools/perf: Python 3 + clang build fixes
Message-ID: <20181005212324.GH20250@kernel.org>
References: <20181005204058.7966-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005204058.7966-1-ehabkost@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 05, 2018 at 05:40:56PM -0300, Eduardo Habkost escreveu:
> This series contains a couple fixes to make it possible to build
> perf with Python 3 and clang.
> 
> Eduardo Habkost (2):
>   perf: Make clang_has_option() work on Python 3
>   perf: More portable way to make CFLAGS work with clang

Thanks! That was fast!

Applying and testing,

- Arnaldo

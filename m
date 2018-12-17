Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E68BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5401C214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389286AbeLQVDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:03:30 -0500
Received: from www62.your-server.de ([213.133.104.62]:55378 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388589AbeLQVDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:03:30 -0500
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gZ02u-0004sS-Hz; Mon, 17 Dec 2018 22:03:24 +0100
Received: from [178.197.248.20] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gZ02u-0003Ys-BP; Mon, 17 Dec 2018 22:03:24 +0100
Subject: Re: [PATCH] bpf: promote bpf_perf_event.h to mandatory UAPI header
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.vnet.ibm.com>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
References: <1544972680-4105-1-git-send-email-yamada.masahiro@socionext.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ffa7d3a4-62be-fb24-b727-8acb029b68fd@iogearbox.net>
Date:   Mon, 17 Dec 2018 22:03:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1544972680-4105-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25216/Mon Dec 17 19:31:08 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/2018 04:04 PM, Masahiro Yamada wrote:
> Since commit c895f6f703ad ("bpf: correct broken uapi for
> BPF_PROG_TYPE_PERF_EVENT program type"), all architectures
> (except um) are required to have bpf_perf_event.h in uapi/asm.
> 
> Add it to mandatory-y so "make headers_install" can check it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to bpf, thanks Masahiro!

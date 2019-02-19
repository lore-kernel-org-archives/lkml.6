Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FC321773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfBSQzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:55:09 -0500
Received: from www62.your-server.de ([213.133.104.62]:50732 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBSQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:55:09 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gw8C5-0003L5-Ta; Tue, 19 Feb 2019 17:24:29 +0100
Received: from [178.197.248.36] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gw8C5-000TCB-Ns; Tue, 19 Feb 2019 17:24:29 +0100
Subject: Re: [PATCH bpf-next v2] bpf: bpftool, fix documentation for attach
 types
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org,
        quentin.monnet@netronome.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com, alban@kinvolk.io, iago@kinvolk.io
References: <20190219141332.23103-1-alban@kinvolk.io>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bcda0ea2-f50b-5b6c-4c37-f4809e7b0dcc@iogearbox.net>
Date:   Tue, 19 Feb 2019 17:24:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190219141332.23103-1-alban@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25365/Tue Feb 19 11:36:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/2019 03:13 PM, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> bpftool has support for attach types "stream_verdict" and
> "stream_parser" but the documentation was referring to them as
> "skb_verdict" and "skb_parse". The inconsistency comes from commit
> b7d3826c2ed6 ("bpf: bpftool, add support for attaching programs to
> maps").
> 
> This patch changes the documentation to match the implementation:
> - "bpftool prog help"
> - man pages
> - bash completion
> 
> Signed-off-by: Alban Crequy <alban@kinvolk.io>

Applied, thanks Alban!

Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29928C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A4C2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfAJO7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:59:36 -0500
Received: from www62.your-server.de ([213.133.104.62]:55798 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAJO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:59:35 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1ghbnx-0000ng-AO; Thu, 10 Jan 2019 15:59:33 +0100
Received: from [178.197.249.40] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1ghbnx-000EIr-3l; Thu, 10 Jan 2019 15:59:33 +0100
Subject: Re: [PATCH] selftests: bpf: install files tcp_(server|client)*.py
To:     Anders Roxell <anders.roxell@linaro.org>, ast@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20190108092303.12597-1-anders.roxell@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c1bb1ee4-6138-04ab-f690-8c988501bda4@iogearbox.net>
Date:   Thu, 10 Jan 2019 15:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190108092303.12597-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25285/Thu Jan 10 11:21:15 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2019 10:23 AM, Anders Roxell wrote:
> When test_tcpbpf_user runs it complains that it can't find files
> tcp_server.py and tcp_client.py.
> 
> Rework so that tcp_server.py and tcp_client.py gets installed, added them
> to the variable TEST_PROGS_EXTENDED.
> 
> Fixes: d6d4f60c3a09 ("bpf: add selftest for tcpbpf")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied to bpf, thanks!

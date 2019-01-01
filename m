Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC42C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 12:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3824D218CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 12:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfAAMwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 07:52:04 -0500
Received: from www62.your-server.de ([213.133.104.62]:56626 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfAAMwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 07:52:04 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1geJWb-0007MC-R6; Tue, 01 Jan 2019 13:52:01 +0100
Received: from [83.9.249.248] (helo=pc59.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1geJWb-000WaK-Jx; Tue, 01 Jan 2019 13:52:01 +0100
Subject: Re: [PATCH bpf-next] selftests/bpf: fix error printing in
 test_devmap()
To:     Xiaozhou Liu <liuxiaozhou@bytedance.com>, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20181221093512.117777-1-liuxiaozhou@bytedance.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0adc725f-ef35-d55c-b201-228973b97126@iogearbox.net>
Date:   Tue, 1 Jan 2019 13:52:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181221093512.117777-1-liuxiaozhou@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25258/Tue Jan  1 07:20:49 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/2018 10:35 AM, Xiaozhou Liu wrote:
> As a simple fix, just print the correct map type.
> 
> Signed-off-by: Xiaozhou Liu <liuxiaozhou@bytedance.com>

Applied to bpf, thanks!

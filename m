Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeERUcU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:32:20 -0400
Received: from www62.your-server.de ([213.133.104.62]:34150 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeERUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:32:15 -0400
Subject: Re: [PATCH] selftests: bpf: config: enable NET_SCH_INGRESS for
 xdp_meta.sh
To: Anders Roxell <anders.roxell@linaro.org>, ast@kernel.org,
        shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20180518182324.23827-1-anders.roxell@linaro.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <eabe5ff5-623e-e36f-1dea-f4f78a362332@iogearbox.net>
Date: Fri, 18 May 2018 22:32:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180518182324.23827-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 08:23 PM, Anders Roxell wrote:
> When running bpf's selftest test_xdp_meta.sh it fails:
> ./test_xdp_meta.sh
> Error: Specified qdisc not found.
> selftests: test_xdp_meta [FAILED]
> 
> Need to enable CONFIG_NET_SCH_INGRESS and CONFIG_NET_CLS_ACT to get the
> test to pass.
> 
> Fixes: 22c8852624fc ("bpf: improve selftests and add tests for meta pointer")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied to bpf tree, thanks Anders!

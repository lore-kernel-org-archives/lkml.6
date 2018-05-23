Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeEWK3b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:29:31 -0400
Received: from www62.your-server.de ([213.133.104.62]:35151 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeEWK3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:29:30 -0400
Subject: Re: [PATCH v2] selftests: net: reuseport_bpf_numa: don't fail if no
 numa support
To: Anders Roxell <anders.roxell@linaro.org>, davem@davemloft.net,
        shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180306151004.31336-1-anders.roxell@linaro.org>
 <20180518222737.16006-1-anders.roxell@linaro.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ce493dd7-5813-6676-9e6b-7a97e74e7676@iogearbox.net>
Date: Wed, 23 May 2018 12:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180518222737.16006-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19/2018 12:27 AM, Anders Roxell wrote:
> The reuseport_bpf_numa test case fails there's no numa support.  The
> test shouldn't fail if there's no support it should be skipped.
> 
> Fixes: 3c2c3c16aaf6 ("reuseport, bpf: add test case for bpf_get_numa_node_id")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied to bpf tree, thanks Anders!

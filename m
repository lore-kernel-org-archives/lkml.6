Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbeD0KKb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:10:31 -0400
Received: from www62.your-server.de ([213.133.104.62]:49689 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757807AbeD0KK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:10:29 -0400
Subject: Re: [PATCH bpf-next v2] bpf, doc: Update bpf_jit_enable limitation
 for CONFIG_BPF_JIT_ALWAYS_ON
To: Leo Yan <leo.yan@linaro.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <1524823374-6174-1-git-send-email-leo.yan@linaro.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fc7b77ee-e1b1-f3cd-2729-617b1830b736@iogearbox.net>
Date: Fri, 27 Apr 2018 12:10:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1524823374-6174-1-git-send-email-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 12:02 PM, Leo Yan wrote:
> When CONFIG_BPF_JIT_ALWAYS_ON is enabled, kernel has limitation for
> bpf_jit_enable, so it has fixed value 1 and we cannot set it to 2
> for JIT opcode dumping; this patch is to update the doc for it.
> 
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Applied to bpf-next, thanks Leo!

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbeDYOOn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:14:43 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:37383 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbeDYOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:14:40 -0400
X-Google-Smtp-Source: AB8JxZpBi0kH/gxg/TY5F172VNFKeaxlEb95jHxP+86ihijggnK8ILDZhpxt8rACYT1dEuv00/P1sw==
Date: Wed, 25 Apr 2018 08:14:36 -0600
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Leo Yan <leo.yan@linaro.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_jit_enable = 2 with
 BPF_JIT_ALWAYS_ON config
Message-ID: <20180425141435.bvolztivms25y2vt@ast-mbp>
References: <1524644322-9263-1-git-send-email-leo.yan@linaro.org>
 <a90e398e-c012-2630-6909-6d413e03cc96@iogearbox.net>
 <20180425092547.GA24401@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425092547.GA24401@leoy-ThinkPad-X240s>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 05:25:47PM +0800, Leo Yan wrote:
> 
> If we have concern for security issue, should we remove support for
> 'bpf_jit_enable = 2' and modify the doc to reflect this change?

I suggest to fix the doc.

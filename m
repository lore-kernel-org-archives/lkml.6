Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeEQUvI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:51:08 -0400
Received: from www62.your-server.de ([213.133.104.62]:46646 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:51:07 -0400
Subject: Re: [PATCH 0/2] bpf: sockmap, fix uninitialized variable and
 double-free
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1526565461.git.gustavo@embeddedor.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b429e5e5-12cb-e05f-f9d9-1f4d1d066428@iogearbox.net>
Date: Thu, 17 May 2018 22:51:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <cover.1526565461.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 04:04 PM, Gustavo A. R. Silva wrote:
> This patchset aims to fix an uninitialized variable issue and
> a double-free issue in __sock_map_ctx_update_elem.
> 
> Both issues were reported by Coverity.
> 
> Thanks.
> 
> Gustavo A. R. Silva (2):
>   bpf: sockmap, fix uninitialized variable
>   bpf: sockmap, fix double-free
> 
>  kernel/bpf/sockmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to bpf-next, thanks Gustavo!

P.s.: Please indicate that next time in the email subject via '[PATCH bpf-next]'.

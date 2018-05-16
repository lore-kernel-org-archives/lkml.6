Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbeEPW7y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:59:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:48296 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbeEPW7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:59:49 -0400
Subject: Re: [PATCH] bpf: add __printf verification to bpf_verifier_vlog
To: Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180516202741.20861-1-malat@debian.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9d240de3-7997-1899-fb91-d9fad24f4af6@iogearbox.net>
Date: Thu, 17 May 2018 00:59:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180516202741.20861-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 10:27 PM, Mathieu Malaterre wrote:
> __printf is useful to verify format and arguments. ‘bpf_verifier_vlog’
> function is used twice in verifier.c in both cases the caller function
> already uses the __printf gcc attribute.
> 
> Remove the following warning, triggered with W=1:
> 
>   kernel/bpf/verifier.c:176:2: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Looks good, applied to bpf-next, thanks Mathieu!

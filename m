Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeDTUNp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 16:13:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:56300 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeDTUNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 16:13:44 -0400
Subject: Re: [PATCH net] bpf: sockmap remove dead check
To: Jann Horn <jannh@google.com>, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.fastabend@gmail.com
References: <20180420161630.233178-1-jannh@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0cbbddea-adb7-71ab-fc3a-167896aeda61@iogearbox.net>
Date: Fri, 20 Apr 2018 22:13:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180420161630.233178-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/2018 06:16 PM, Jann Horn wrote:
> Remove dead code that bails on `attr->value_size > KMALLOC_MAX_SIZE` - the
> previous check already bails on `attr->value_size != 4`.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Applied to bpf tree, thanks Jann!

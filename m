Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbeAaQxR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:53:17 -0500
Received: from www62.your-server.de ([213.133.104.62]:41275 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeAaQxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:53:15 -0500
Subject: Re: [PATCH bpf-next v8 0/5] libbpf: add XDP binding support
To: Eric Leblond <eric@regit.org>
Cc: alexei.starovoitov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <a26f90e9-5028-f8a9-a1e6-83a6c46b4e0b@iogearbox.net>
 <20180130205042.19647-1-eric@regit.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ab472a93-49c4-fd35-0e61-1b7691b81c39@iogearbox.net>
Date: Wed, 31 Jan 2018 17:53:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180130205042.19647-1-eric@regit.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 09:50 PM, Eric Leblond wrote:
> Hello Daniel,
> 
> No problem with the delay in the answer. I'm doing far worse.
> 
> Here is an updated version:
> - add if_link.h in uapi and remove the definition
> - fix a commit message
> - remove uapi from a include

Fyi, this still needs to wait for a bit in the queue due to current
merge window where bpf-next is closed during that time [0]. Thanks!

  [0] https://www.spinics.net/lists/netdev/msg481490.html

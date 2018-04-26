Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756644AbeDZO40 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:56:26 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:39901 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755698AbeDZO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:56:21 -0400
X-Google-Smtp-Source: AIpwx481FMmxv9HB56kTjdXitq/8/Ds5fZwePKq0DDK6KVo6RFBLKCB45Ik7WfdQbQwPuF6Vo+wEOQ==
Subject: Re: [PATCH v2 net-next 0/2] tcp: mmap: rework zerocopy receive
To: Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20180425214307.159264-1-edumazet@google.com>
 <CACSApvZF8CJqcRx7FGkMGitBiC6m0=_FT9XRZ=VV07U62wGM3Q@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a2c405e1-0ebc-dd33-fb0d-575bf06a1ff6@gmail.com>
Date: Thu, 26 Apr 2018 07:56:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACSApvZF8CJqcRx7FGkMGitBiC6m0=_FT9XRZ=VV07U62wGM3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 06:20 PM, Soheil Hassas Yeganeh wrote:
> 
> Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> 
>

Thanks Soheil for reviewing.

I have changed setsockopt() to getsockopt() so chose to not carry your Acked-by

Please add it back if you agree, thanks !

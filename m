Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965904AbeE2SSd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:18:33 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:40851 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936888AbeE2SSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:18:18 -0400
X-Google-Smtp-Source: ADUXVKJPePUHwhMTT9VxYrv0woi72E0CFh0NaMSp2cXdvEbNr685AL7fuCajW0tVLSOwBJIjRX+Tw48CpxiLh/+Vk5Q=
MIME-Version: 1.0
In-Reply-To: <4a060ed5-f147-6778-caa2-7866b1f04479@gmail.com>
References: <20180529024018.12740-1-yuehaibing@huawei.com> <CAK8P3a0jnU69RQ8jLF82GofE=fgENMVoWkObYvro82f+q=p_XA@mail.gmail.com>
 <4a060ed5-f147-6778-caa2-7866b1f04479@gmail.com>
From: Song Liu <liu.song.a23@gmail.com>
Date: Tue, 29 May 2018 11:18:15 -0700
Message-ID: <CAPhsuW7tkQVY0rVRt2=cAHf_fif7W_73Ns7_mnt3CriMbGEhrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: hide the unused 'off' variable
To: John Fastabend <john.fastabend@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, YueHaibing <yuehaibing@huawei.com>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TIJDHc012732

On Tue, May 29, 2018 at 8:53 AM, John Fastabend
<john.fastabend@gmail.com> wrote:
> On 05/29/2018 03:35 AM, Arnd Bergmann wrote:
>> On Tue, May 29, 2018 at 4:40 AM, YueHaibing <yuehaibing@huawei.com> wrote:
>>> The local variable is only used while CONFIG_IPV6 enabled
>>>
>>> net/core/filter.c: In function ‘sk_msg_convert_ctx_access’:
>>> net/core/filter.c:6489:6: warning: unused variable ‘off’ [-Wunused-variable]
>>>   int off;
>>>       ^
>>> This puts it into #ifdef.
>>>
>>> Fixes: 303def35f64e ("bpf: allow sk_msg programs to read sock fields")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>
>> I was about to send the same patch and found you had already sent one.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>
> Thanks! I'm curious why kbuild bot didn't catch this. Will
> try to dig into that in a bit.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754837AbeCGWRS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:17:18 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:42383 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeCGWRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:17:17 -0500
X-Google-Smtp-Source: AG47ELueV0oV5kYIc2viPjrmQproWpXzvCtIXYWWs8IcVp4yXNK643x/dWtkzaNGRGSSJeA2wnJ7mejqOWA6XDgJJ5Y=
MIME-Version: 1.0
In-Reply-To: <2aa430ae-9d75-a6e4-8976-fd3cb63c35d0@linux.vnet.ibm.com>
References: <20180206093430.7550-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180206093430.7550-2-ravi.bangoria@linux.vnet.ibm.com> <CAGXu5jLT+0=eSV-o8Ogd_a1krM6nppvqQ_fqn8Rn=ArPRwq7Ow@mail.gmail.com>
 <536fd857-2ee9-ef9c-4cc5-588ae1a07355@linux.vnet.ibm.com> <8b812c4f-dfd8-928e-d5dd-f65679d0a88e@linux.vnet.ibm.com>
 <CAGXu5jLhTdkyeJv6v6hf-qB6U3eZBFUq0KrT9CVgfSTZa1yMmA@mail.gmail.com> <2aa430ae-9d75-a6e4-8976-fd3cb63c35d0@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Mar 2018 14:17:15 -0800
X-Google-Sender-Auth: w8TvVNH4SDe3dVHEFRhcqhLi7YA
Message-ID: <CAGXu5jKZd0CdJKshm1F_qdW0F5TwtdeGSw6wST6NsfWchEzBiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] trace_uprobe: Simplify probes_seq_show()
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: wangnan0 <wangnan0@huawei.com>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 8:12 PM, Ravi Bangoria
<ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>
> On 03/07/2018 03:34 AM, Kees Cook wrote:
>> On Tue, Mar 6, 2018 at 12:12 AM, Ravi Bangoria
>> <ravi.bangoria@linux.vnet.ibm.com> wrote:
>>>
>>> On 02/08/2018 09:13 AM, Ravi Bangoria wrote:
>>>> Wang, ping :)
>>>>
>>>> Kees, I don't hear back from Wang and no one has reported any issues with
>>>> the patches yet. Can I have your Acked-by?
>> I didn't see a v2 of these patches with the output fixed?
>
> Kees, I didn't send v2 because those 0s seems unnecessary to me.

Oh, okay. I don't care either way. That's up to whoever consumes that
output. Usually it's bad form to change formatting for a userspace
API, but if nothing cares, then sure. :)

> Please let me know if you still wants to show them. Will re-spin :)

AIUI, it's "safer" to include them since that's what it did before.

-Kees

>
> Thanks,
> Ravi
>
> PS: Changing Masami's email address in cc.
>



-- 
Kees Cook
Pixel Security

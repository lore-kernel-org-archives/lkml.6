Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeCURag (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:30:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43281 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeCURad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:30:33 -0400
X-Google-Smtp-Source: AG47ELt6FHWq1in2/Sko27wbrdAjs6PlE3eIpHAzn/xKmlPFNzrjhfdOvtpBzqbzqrSzd3XJUcP26A==
Subject: Re: [PATCHv2 2/2] bpftool: Adjust to new print_bpf_insn interface
To: Jiri Olsa <jolsa@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20180321150212.5586-1-jolsa@kernel.org>
 <20180321150212.5586-2-jolsa@kernel.org>
 <c27c5c1c-79ee-3ed2-d1c3-a011ead4edea@netronome.com>
 <20180321164324.GD2707@krava>
 <774f0eca-72cf-1c70-e025-beea2084ebe0@iogearbox.net>
 <20180321170019.GE2707@krava>
From: Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <83bca487-ade9-7b8e-c303-11256ce50d77@netronome.com>
Date: Wed, 21 Mar 2018 17:30:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321170019.GE2707@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-21 18:00 UTC+0100 ~ Jiri Olsa <jolsa@redhat.com>
> On Wed, Mar 21, 2018 at 05:44:52PM +0100, Daniel Borkmann wrote:
> 
> SNIP
> 
>>>> Hi Jiri, this code has changed in the tree. It was moved to
>>>> tools/bpf/bpftool/xlated_dumper.c, and there is now a third function to
>>>> update: print_insn_for_graph(). Could you please rebase the patch?
>>>
>>> sure.. I was over perf tree, I'll check on bpf tree
>>
>> Just to be sure, it should be bpf-next. bpf is for fixes only.
> 
> v2 attached
> 
> thanks,
> jirka
> 
> 
> ---
> Change bpftool to skip the removed struct bpf_verifier_env
> argument in print_bpf_insn. It was passed as NULL anyway.
> 
> No functional change intended.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/bpftool/xlated_dumper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Thank you!
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

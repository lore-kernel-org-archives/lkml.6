Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeCWQro (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:47:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:45562 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCWQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:47:43 -0400
Subject: Re: [PATCH 0/2] bpf: Change print_bpf_insn interface
To: Quentin Monnet <quentin.monnet@netronome.com>,
        Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20180323104129.14989-1-jolsa@kernel.org>
 <f5586965-1447-ba8e-a27c-398b221f18e3@netronome.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c77e304f-8c4a-7e2e-dcb7-961190b13956@iogearbox.net>
Date: Fri, 23 Mar 2018 17:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <f5586965-1447-ba8e-a27c-398b221f18e3@netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 02:34 PM, Quentin Monnet wrote:
> 2018-03-23 11:41 UTC+0100 ~ Jiri Olsa <jolsa@kernel.org>
>> hi,
>> this patchset removes struct bpf_verifier_env argument
>> from print_bpf_insn function (patch 1) and changes user
>> space bpftool user to use it that way (patch 2).
>>
>> thanks,
>> jirka
>>
>> ---
>> Jiri Olsa (2):
>>       bpf: Remove struct bpf_verifier_env argument from print_bpf_insn
>>       bpftool: Adjust to new print_bpf_insn interface
>>
>>  kernel/bpf/disasm.c               | 52 ++++++++++++++++++++++++++--------------------------
>>  kernel/bpf/disasm.h               |  5 +----
>>  kernel/bpf/verifier.c             | 44 +++++++++++++++++++++++++++-----------------
>>  tools/bpf/bpftool/xlated_dumper.c | 12 ++++++------
>>  4 files changed, 60 insertions(+), 53 deletions(-)
>>
> 
> Thanks, this version looks good to me. Please keep the "Reviewed-by"
> tags when resubmitting new versions of your patch sets :)
> 
> For the series:
> Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

Applied to bpf-next, thanks everyone!

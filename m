Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeCWNeY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:34:24 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38332 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeCWNeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:34:22 -0400
X-Google-Smtp-Source: AG47ELuA04MEj3qmF11cMavH2+g5tQ/I24KLn/BdHkENpSfADdX3cXmPyguBn3oknblKctfzqpKccw==
Subject: Re: [PATCH 0/2] bpf: Change print_bpf_insn interface
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20180323104129.14989-1-jolsa@kernel.org>
From: Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <f5586965-1447-ba8e-a27c-398b221f18e3@netronome.com>
Date: Fri, 23 Mar 2018 13:34:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323104129.14989-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-23 11:41 UTC+0100 ~ Jiri Olsa <jolsa@kernel.org>
> hi,
> this patchset removes struct bpf_verifier_env argument
> from print_bpf_insn function (patch 1) and changes user
> space bpftool user to use it that way (patch 2).
> 
> thanks,
> jirka
> 
> ---
> Jiri Olsa (2):
>       bpf: Remove struct bpf_verifier_env argument from print_bpf_insn
>       bpftool: Adjust to new print_bpf_insn interface
> 
>  kernel/bpf/disasm.c               | 52 ++++++++++++++++++++++++++--------------------------
>  kernel/bpf/disasm.h               |  5 +----
>  kernel/bpf/verifier.c             | 44 +++++++++++++++++++++++++++-----------------
>  tools/bpf/bpftool/xlated_dumper.c | 12 ++++++------
>  4 files changed, 60 insertions(+), 53 deletions(-)
> 

Thanks, this version looks good to me. Please keep the "Reviewed-by"
tags when resubmitting new versions of your patch sets :)

For the series:
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

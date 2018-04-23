Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932461AbeDWULq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:11:46 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:41789 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932393AbeDWULk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:11:40 -0400
X-Google-Smtp-Source: AIpwx48lffZIRezapvqx818ttlOe5IcI90GgR8EKBBWWrNhVDc3mAw5tAi+vZBpGoFM9rPgpvsnX/A==
Date: Mon, 23 Apr 2018 14:11:36 -0600
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCH 0/3] bpf: Store/dump license string for loaded program
Message-ID: <20180423201134.r56ts7usec4jjnbh@ast-mbp>
References: <20180423065927.23127-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423065927.23127-1-jolsa@kernel.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 08:59:24AM +0200, Jiri Olsa wrote:
> hi,
> sending the change to store and dump the license
> info for loaded BPF programs. It's important for
> us get the license info, when investigating on
> screwed up machine.

hmm. boolean flag whether bpf prog is gpl or not
is already exposed via bpf_prog_info.
I see no point of wasting extra 128 bytes of kernel memory.

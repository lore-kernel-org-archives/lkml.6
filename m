Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756203AbeDZUtd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:49:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:43968 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeDZUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:49:31 -0400
Subject: Re: [PATCHv3 3/3] tools bpftool: Display license GPL compatible in
 prog show/list
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jakub Kicinski <kubakici@wp.pl>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
References: <20180425174108.6586-1-jolsa@kernel.org>
 <20180425174108.6586-4-jolsa@kernel.org>
 <20180425140346.3e0f3ba7@cakuba.netronome.com>
 <0e84fe67-59c9-a419-5ff7-05be2aa1991e@iogearbox.net>
 <20180426073905.GI3396@krava>
 <639b2b78-af9e-4605-2b33-9bd1af8e760a@iogearbox.net>
 <20180426081801.GK3396@krava>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <dbc91e08-4c99-e01f-eab5-ac235812cee7@iogearbox.net>
Date: Thu, 26 Apr 2018 22:49:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180426081801.GK3396@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 10:18 AM, Jiri Olsa wrote:
[...]
> v3 of the last patch attached, the branch is also updated
> 
> thanks,
> jirka
> 
> 
> ---
> Display the license "gpl" string in bpftool prog command, like:
> 
>   # bpftool prog list
>   5: tracepoint  name func  tag 57cd311f2e27366b  gpl
>           loaded_at Apr 26/09:37  uid 0
>           xlated 16B  not jited  memlock 4096B
> 
>   # bpftool --json --pretty prog show
>   [{
>           "id": 5,
>           "type": "tracepoint",
>           "name": "func",
>           "tag": "57cd311f2e27366b",
>           "gpl_compatible": true,
>           "loaded_at": "Apr 26/09:37",
>           "uid": 0,
>           "bytes_xlated": 16,
>           "jited": false,
>           "bytes_memlock": 4096
>       }
>   ]
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Ok, v2 from prior two patches and v3 of this one applied to bpf-next. Please
next time always submit a fresh new series at once, thanks Jiri.

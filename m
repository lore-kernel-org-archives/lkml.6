Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeEUS6V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:58:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41282 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeEUS6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:58:17 -0400
X-Google-Smtp-Source: AB8JxZq091whpn43rY73SFWNwDHMygFWt4RYExmRcLJn+u/2gMRSKqD4syQSCEBn6nkIUgbzet/GdQ==
Date: Mon, 21 May 2018 11:58:13 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH 0/3] bpf: add boot parameters for sysctl knobs
Message-ID: <20180521185811.2r6372timh5rfs5n@ast-mbp.dhcp.thefacebook.com>
References: <20180521122923.GA15717@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521122923.GA15717@asgard.redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 02:29:30PM +0200, Eugene Syromiatnikov wrote:
> Hello.
> 
> This patch set adds ability to set default values for
> kernel.unprivileged_bpf_disable, net.core.bpf_jit_harden,
> net.core.bpf_jit_kallsyms sysctl knobs as well as option to override
> them via a boot-time kernel parameter.

Commits log not only should explain 'what' is being done by the patch,
but 'why' as well.

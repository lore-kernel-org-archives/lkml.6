Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeEUM2k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:28:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750923AbeEUM2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:28:39 -0400
Date: Mon, 21 May 2018 14:29:30 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH 0/3] bpf: add boot parameters for sysctl knobs
Message-ID: <20180521122923.GA15717@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This patch set adds ability to set default values for
kernel.unprivileged_bpf_disable, net.core.bpf_jit_harden,
net.core.bpf_jit_kallsyms sysctl knobs as well as option to override
them via a boot-time kernel parameter.

Eugene Syromiatnikov (3):
  bpf: add ability to configure unprivileged BPF via boot-time parameter
  bpf: add ability to configure BPF JIT hardening via boot-time
    parameter
  bpf: add ability to configure BPF JIT kallsyms export at the boot time

 Documentation/admin-guide/kernel-parameters.txt | 28 ++++++++
 init/Kconfig                                    | 90 +++++++++++++++++++++++++
 kernel/bpf/core.c                               | 31 +++++++++
 kernel/bpf/syscall.c                            | 16 +++++
 4 files changed, 165 insertions(+)

-- 
2.1.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbeDWGwN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:52:13 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33178 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754078AbeDWGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:52:08 -0400
X-Google-Smtp-Source: AIpwx49U3u8+iyV9zU08GHZ8zPLXHU574SrPuR7LyblpkBHi47+pFii54+9L0OL96JUjDTNTEypbiw==
Date: Mon, 23 Apr 2018 08:52:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: valdis.kletnieks@vt.edu
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: next-20180416 - warnings from 'make tools/perf'
Message-ID: <20180423065204.cgzu7mvivrph3gfw@gmail.com>
References: <61890.1524462741@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61890.1524462741@turing-police.cc.vt.edu>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* valdis.kletnieks@vt.edu <valdis.kletnieks@vt.edu> wrote:

> Seeing these warnings.  'diff' tells me that the files
> are in fact significantly different.
> 
> Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
> Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'
> Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' differs from latest version at 'arch/x86/include/asm/required-features.h'
> Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
> Warning: Kernel ABI header at 'tools/arch/arm/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm/include/uapi/asm/kvm.h'
> Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
> Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'

The warnings are harmless, and they should be fixed in v4.17-rc2.

Thanks,

	Ingo

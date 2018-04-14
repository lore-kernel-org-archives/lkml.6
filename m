Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeDNRbw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 13:31:52 -0400
Received: from [195.159.176.226] ([195.159.176.226]:49824 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbeDNRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 13:31:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Akemi Yagi <toracat@elrepo.org>
Subject: Re: kernel-4.9.94 compile error: 'KMOD_DECOMP_LEN' undeclared
Date: Sat, 14 Apr 2018 17:29:28 +0000 (UTC)
Message-ID: <patdpo$3ej$1@blaine.gmane.org>
References: <CAEwRVpOFS5UsyVHkHr+w_OR0eSpvT-CZGG6b4Vr6gxkc4rwO6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Pan/0.135 (Tomorrow I'll Wake Up and Scald Myself with Tea; GIT
        30dc37b master)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2018 17:41:13 +0800, Teck Choon Giam wrote:

> Hi,
> 
> Compile linux-4.9.94 will have error related to KMOD_DECOMP_LEN
> undeclared.  Searching string related to KMOD_DECOMP_LEN in
> linux-4.9.94 and linux-4.15.17 sources as below:
> 
> <mock-chroot>sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.15.17
> ./linux-4.15.17/tools/perf/tests/code-reading.c: char
> decomp_name[KMOD_DECOMP_LEN];
> ./linux-4.15.17/tools/perf/util/dso.h:#define KMOD_DECOMP_LEN
> sizeof(KMOD_DECOMP_NAME)
> ./linux-4.15.17/tools/perf/util/annotate.c: char tmp[KMOD_DECOMP_LEN];
> ./linux-4.15.17/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
> sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.9.94
> ./linux-4.9.94/tools/perf/tests/code-reading.c: char
> decomp_name[KMOD_DECOMP_LEN];
> ./linux-4.9.94/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
> 
> So I guess for linux-4.9.94 has not define KMOD_DECOMP_LEN in
> tools/perf/util/dso.h?
> 
> Thanks.
> 
> Regards,
> Giam Teck Choon

Just a note to say that we (ELRepo) see the same error when building kernel-4.4.128 on RHEL 6 and RHEL 7. Kernel 4.4.127 built fine.

Akemi
The ELRepo Project

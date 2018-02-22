Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933503AbeBVRai (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:30:38 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36281 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933390AbeBVRah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:30:37 -0500
X-Google-Smtp-Source: AH8x2268KMbX7NrHeCbYMT5sYmeE+FBeaTIOqBa9YfxNjotgmCgDLPUp8NcJS8ihBtGYhnCwaQnuTba8JudhCYAJgMM=
MIME-Version: 1.0
In-Reply-To: <20180222130738.GG30681@dhcp22.suse.cz>
References: <20180212133731.GE3443@dhcp22.suse.cz> <87r2ppvaeq.fsf@concordia.ellerman.id.au>
 <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
 <87d1192nzc.fsf@concordia.ellerman.id.au> <20180213103213.GP3443@dhcp22.suse.cz>
 <CAGXu5jJZROQMxzxu+Dp3mVMktSg-oTB6pqk7fUyM_6_2oa9c_A@mail.gmail.com>
 <20180214092045.GZ3443@dhcp22.suse.cz> <CAGXu5jJCN_Js9rvM4RMjxDCDd4tVzWDo-jdnFiZs1D9e3cunrw@mail.gmail.com>
 <20180222130738.GG30681@dhcp22.suse.cz>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 22 Feb 2018 09:30:35 -0800
X-Google-Sender-Auth: 8kCDMolcIjqZARdIbna8vGXMyUc
Message-ID: <CAGXu5jLLDOqoSn9usuA-pRLb5X=zK6MYdUVMPEh7x7oMgnU5cQ@mail.gmail.com>
Subject: Re: samples/seccomp/ broken when cross compiling s390, ppc allyesconfig
To: Michal Hocko <mhocko@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Will Drewry <wad@chromium.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 5:07 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Wed 14-02-18 09:14:47, Kees Cook wrote:
> [...]
>> I can send it through my seccomp tree via James Morris.
>
> Could you please do it?

Hi! Yes, sorry, this fell through the cracks. Now applied.

-Kees

-- 
Kees Cook
Pixel Security

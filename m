Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeBWJgo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:36:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:39930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbeBWJgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:36:42 -0500
Date: Fri, 23 Feb 2018 10:12:48 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Will Drewry <wad@chromium.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: samples/seccomp/ broken when cross compiling s390, ppc
 allyesconfig
Message-ID: <20180223091248.GT30681@dhcp22.suse.cz>
References: <20180212133731.GE3443@dhcp22.suse.cz>
 <87r2ppvaeq.fsf@concordia.ellerman.id.au>
 <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
 <87d1192nzc.fsf@concordia.ellerman.id.au>
 <20180213103213.GP3443@dhcp22.suse.cz>
 <CAGXu5jJZROQMxzxu+Dp3mVMktSg-oTB6pqk7fUyM_6_2oa9c_A@mail.gmail.com>
 <20180214092045.GZ3443@dhcp22.suse.cz>
 <CAGXu5jJCN_Js9rvM4RMjxDCDd4tVzWDo-jdnFiZs1D9e3cunrw@mail.gmail.com>
 <20180222130738.GG30681@dhcp22.suse.cz>
 <CAGXu5jLLDOqoSn9usuA-pRLb5X=zK6MYdUVMPEh7x7oMgnU5cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLLDOqoSn9usuA-pRLb5X=zK6MYdUVMPEh7x7oMgnU5cQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-02-18 09:30:35, Kees Cook wrote:
> On Thu, Feb 22, 2018 at 5:07 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Wed 14-02-18 09:14:47, Kees Cook wrote:
> > [...]
> >> I can send it through my seccomp tree via James Morris.
> >
> > Could you please do it?
> 
> Hi! Yes, sorry, this fell through the cracks. Now applied.

Thanks!

-- 
Michal Hocko
SUSE Labs

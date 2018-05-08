Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933102AbeEHQaF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:30:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54404 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932743AbeEHQ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:29:07 -0400
X-Google-Smtp-Source: AB8JxZpwa7bQ8FU2LGN9J0opngSIR7fSODsPqgdipAmxXWUwoW049/A0Vc+LwL0cqCdknw2UmQzYAQ==
Date: Tue, 8 May 2018 18:28:55 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Jeff Layton <jlayton@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "Tobin C. Harding" <me@tobin.cc>, SeongJae Park <sj38.park@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Helmut Grohne <h.grohne@intenta.de>
Subject: Re: [PATCH 05/18] docs: core-api: add cachetlb documentation
Message-ID: <20180508162855.GA8536@andrea>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <07b59879d34502828467f0190f941e23e08fdc81.1525684985.git.mchehab+samsung@kernel.org>
 <20180507122937.GA5813@andrea>
 <87y3gu43d3.fsf@intel.com>
 <20180508160242.GA5469@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508160242.GA5469@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 06:02:42PM +0200, Andrea Parri wrote:
> Hi Jani,
> 
> On Tue, May 08, 2018 at 05:40:56PM +0300, Jani Nikula wrote:
> > On Mon, 07 May 2018, Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> > > On Mon, May 07, 2018 at 06:35:41AM -0300, Mauro Carvalho Chehab wrote:
> > >> The cachetlb.txt is already in ReST format. So, move it to the
> > >> core-api guide, where it belongs.
> > >> 
> > >> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > >> ---
> > >>  Documentation/00-INDEX                                | 2 --
> > >>  Documentation/{cachetlb.txt => core-api/cachetlb.rst} | 0
> > >>  Documentation/core-api/index.rst                      | 1 +
> > >>  Documentation/memory-barriers.txt                     | 2 +-
> > >>  Documentation/translations/ko_KR/memory-barriers.txt  | 2 +-
> > >>  5 files changed, 3 insertions(+), 4 deletions(-)
> > >>  rename Documentation/{cachetlb.txt => core-api/cachetlb.rst} (100%)
> > >
> > > I see a few "inline" references to the .txt file in -rc4 (see below):
> > > I am not sure if you managed to update them too.
> > 
> > Side note, there's scripts/documentation-file-ref-check to grep the
> > kernel tree for things that look like file references to Documentation/*
> > and complain if they don't exist.
> > 
> > I get about 350+ hits with that, patches welcome! ;)
> 
> Thanks for pointing out the script/results.
> 
> It's also worth stressing, I think, the fact that some of those are from
> the MAINTAINERS file; I stumbled accross one of them yesterday:
> 
>   http://lkml.kernel.org/r/1525707655-3542-1-git-send-email-andrea.parri@amarulasolutions.com
> 
> False positives apart (e.g., the four references in tools/memory-model/),
> those are regressions from my POV: please do not (consiously) merge more!

s/four/five

  Andrea


> 
>   Andrea
> 
> 
> > 
> > 
> > BR,
> > Jani.
> > 
> > 
> > >
> > > ./arch/microblaze/include/asm/cacheflush.h:/* Look at Documentation/cachetlb.txt */
> > > ./arch/unicore32/include/asm/cacheflush.h: *	See Documentation/cachetlb.txt for more information.
> > > ./arch/arm64/include/asm/cacheflush.h: *	See Documentation/cachetlb.txt for more information. Please note that
> > > ./arch/arm/include/asm/cacheflush.h: *	See Documentation/cachetlb.txt for more information.
> > > ./arch/xtensa/include/asm/cacheflush.h: * (see also Documentation/cachetlb.txt)
> > > ./arch/xtensa/include/asm/cacheflush.h:/* This is not required, see Documentation/cachetlb.txt */
> > >
> > >   Andrea
> > >
> > >
> > >> 
> > >> diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
> > >> index 53699c79ee54..04074059bcdc 100644
> > >> --- a/Documentation/00-INDEX
> > >> +++ b/Documentation/00-INDEX
> > >> @@ -76,8 +76,6 @@ bus-devices/
> > >>  	- directory with info on TI GPMC (General Purpose Memory Controller)
> > >>  bus-virt-phys-mapping.txt
> > >>  	- how to access I/O mapped memory from within device drivers.
> > >> -cachetlb.txt
> > >> -	- describes the cache/TLB flushing interfaces Linux uses.
> > >>  cdrom/
> > >>  	- directory with information on the CD-ROM drivers that Linux has.
> > >>  cgroup-v1/
> > >> diff --git a/Documentation/cachetlb.txt b/Documentation/core-api/cachetlb.rst
> > >> similarity index 100%
> > >> rename from Documentation/cachetlb.txt
> > >> rename to Documentation/core-api/cachetlb.rst
> > >> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> > >> index c670a8031786..d4d71ee564ae 100644
> > >> --- a/Documentation/core-api/index.rst
> > >> +++ b/Documentation/core-api/index.rst
> > >> @@ -14,6 +14,7 @@ Core utilities
> > >>     kernel-api
> > >>     assoc_array
> > >>     atomic_ops
> > >> +   cachetlb
> > >>     refcount-vs-atomic
> > >>     cpu_hotplug
> > >>     idr
> > >> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > >> index 6dafc8085acc..983249906fc6 100644
> > >> --- a/Documentation/memory-barriers.txt
> > >> +++ b/Documentation/memory-barriers.txt
> > >> @@ -2903,7 +2903,7 @@ is discarded from the CPU's cache and reloaded.  To deal with this, the
> > >>  appropriate part of the kernel must invalidate the overlapping bits of the
> > >>  cache on each CPU.
> > >>  
> > >> -See Documentation/cachetlb.txt for more information on cache management.
> > >> +See Documentation/core-api/cachetlb.rst for more information on cache management.
> > >>  
> > >>  
> > >>  CACHE COHERENCY VS MMIO
> > >> diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
> > >> index 0a0930ab4156..081937577c1a 100644
> > >> --- a/Documentation/translations/ko_KR/memory-barriers.txt
> > >> +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> > >> @@ -2846,7 +2846,7 @@ CPU 의 캐시에서 RAM 으로 쓰여지는 더티 캐시 라인에 의해 덮
> > >>  문제를 해결하기 위해선, 커널의 적절한 부분에서 각 CPU 의 캐시 안의 문제가 되는
> > >>  비트들을 무효화 시켜야 합니다.
> > >>  
> > >> -캐시 관리에 대한 더 많은 정보를 위해선 Documentation/cachetlb.txt 를
> > >> +캐시 관리에 대한 더 많은 정보를 위해선 Documentation/core-api/cachetlb.rst 를
> > >>  참고하세요.
> > >>  
> > >>  
> > >> -- 
> > >> 2.17.0
> > >> 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-doc" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > -- 
> > Jani Nikula, Intel Open Source Technology Center

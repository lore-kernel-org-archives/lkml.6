Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeCIP6G (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:58:06 -0500
Received: from foss.arm.com ([217.140.101.70]:54246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbeCIP6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:58:04 -0500
Date: Fri, 9 Mar 2018 15:58:09 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ganapatrao Kulkarni <gklkml16@gmail.com>,
        William Cohen <wcohen@redhat.com>, mark.rutland@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <Robert.Richter@cavium.com>,
        Ingo Molnar <mingo@redhat.com>, jnair@caviumnetworks.com,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf vendor events arm64: Enable JSON events for
 ThunderX2 B0
Message-ID: <20180309155808.GP15537@arm.com>
References: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
 <3384d33f-c927-740a-97f1-b20775ef2c7b@redhat.com>
 <20180307143832.GJ3701@kernel.org>
 <CAKTKpr4zMcRLykw8xwWJKf2eiuCrf2RuJ7kexGRQNN7_OdJ=uQ@mail.gmail.com>
 <52328144-3a2a-af03-273b-3a2f3bdadda6@redhat.com>
 <CAKTKpr7HgsdZ90k0_evSq_aZW-uGSKwLndHOQ2Jahajj3Gkc0Q@mail.gmail.com>
 <CAKTKpr5=Doy2bQz8yYcoRNUGQ1HEgLcqk7U+4m-=1T_TZWa4HA@mail.gmail.com>
 <20180309143415.GB4194@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309143415.GB4194@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 11:34:15AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 09, 2018 at 07:57:04PM +0530, Ganapatrao Kulkarni escreveu:
> > Hi Arnaldo,
> > 
> > can you please pull-in this patch?
> 
> So everybody is Ok with this? Can I have some Acked-by: from subject
> matter experts?

The original patch looks fine to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

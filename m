Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750965AbeCIAGb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:06:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:39876 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbeCIAGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:06:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="37179860"
Date: Thu, 8 Mar 2018 16:06:14 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ilya Pronin <ipronin@twitter.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
Message-ID: <20180309000614.GN25017@tassilo.jf.intel.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
 <20180306170011.GD25017@tassilo.jf.intel.com>
 <CAM_iQpUfRMW4aGfaTdFqCRwuuLXFX69Aewg+k-aa6BMUKSrhTA@mail.gmail.com>
 <20180306175320.GE25017@tassilo.jf.intel.com>
 <CAM_iQpVQs0YTckbo9F0zjPsSL+=ksVZvdcLO-QHTONcZc84eKg@mail.gmail.com>
 <CA+Xn3kw2FZ4m1TossMT35KKJ7EsSV=ykdWKCHtjRs1oefdXWNw@mail.gmail.com>
 <20180307170411.GI25017@tassilo.jf.intel.com>
 <CA+Xn3kzwsHZU7wbgVVVGTtu-En9g8mWPTCe5q-8CPETSgMzatw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Xn3kzwsHZU7wbgVVVGTtu-En9g8mWPTCe5q-8CPETSgMzatw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 01:52:15PM -0800, Ilya Pronin wrote:
> The patch merely eliminated those 2 unexpected fields. But from what I
> saw they were violating the assumption that all lines have the same
> number of fields.

Ok then I must have misread the patch. Sorry about that.
It's fine for me then. I think Arnaldo has it already merged anyways.

-Andi

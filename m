Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeEBQ5l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:57:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751344AbeEBQ5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:57:40 -0400
Date: Wed, 2 May 2018 18:57:37 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Stephane Eranian <eranian@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, mingo@elte.hu,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] perf record: dead code perf_event__synthesize_id_index()
Message-ID: <20180502165737.GF11539@krava>
References: <CABPqkBTm+9Wsa21GVXpogWUDNkpRF4eyZOPGa8QJCvdV2Lz2rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTm+9Wsa21GVXpogWUDNkpRF4eyZOPGa8QJCvdV2Lz2rA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 04:38:33PM +0000, Stephane Eranian wrote:
> Hi,
> 
> It looks like perf_event__synthesize_id_index() is dead code in the current
> tip
> tree. I don't see any invocation of the function anywhere in perf.I
> understand why
> you'd want to keep the rest of the code related to  PERF_RECORD_ID_INDEX
> because some perf.data file may have this user-level record type. But the
> synthesize code is not needed anymore, in my opinion.
> 
> Shouldn't we remove this code?

looks like there never was any user of it, probably some
preparation for follow up that haven't happened yet.. Adrian?

jirka

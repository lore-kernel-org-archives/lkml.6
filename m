Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6544DC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64AB20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64AB20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeI2Mqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:46:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55439 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbeI2Mqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:46:48 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g68bE-0001EM-Uj; Sat, 29 Sep 2018 08:19:33 +0200
Date:   Sat, 29 Sep 2018 08:19:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
In-Reply-To: <20180928204556.GB32651@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1809290817160.1432@nanos.tec.linutronix.de>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com> <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de> <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com> <alpine.DEB.2.21.1809281542180.2004@nanos.tec.linutronix.de>
 <0feb9867-0040-0306-a95b-4b6df1818312@linux.intel.com> <alpine.DEB.2.21.1809281932040.1432@nanos.tec.linutronix.de> <20180928204556.GB32651@tassilo.jf.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018, Andi Kleen wrote:
> So there isn't a single answer, and that is why it is important
> that this if configurable.

I said clearly that I'm not opposed against making it configurable. But
because there is no single answer, it's even more important to have proper
documentation. And that's all I'm asking for aside of making it opt-in
instead of a wholesale expose everything approach.

Thanks,

	tglx



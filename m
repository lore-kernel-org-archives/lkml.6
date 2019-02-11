Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34347C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035D1222B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfBKOQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:16:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39343 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBKOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:16:13 -0500
Received: from [5.158.153.55] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtCNN-0006vA-Hj; Mon, 11 Feb 2019 15:16:01 +0100
Date:   Mon, 11 Feb 2019 15:15:55 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
cc:     Jonatan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] perf-security: document perf_events/Perf resource
 control
In-Reply-To: <969b6ea5-a5bf-70b7-7031-38b07538f744@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902111514550.3197@nanos.tec.linutronix.de>
References: <fd896eec-7833-f23a-ad2f-95005dca5fff@linux.intel.com> <a108c800-d6c1-fac1-b73b-e390e579e6ef@linux.intel.com> <alpine.DEB.2.21.1902102300210.8784@nanos.tec.linutronix.de> <969b6ea5-a5bf-70b7-7031-38b07538f744@linux.intel.com>
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

On Mon, 11 Feb 2019, Alexey Budankov wrote:
> On 11.02.2019 1:34, Thomas Gleixner wrote:
> > On Thu, 7 Feb 2019, Alexey Budankov wrote:
> > 
> > General note: Please stay in the 80 char limit for all of the text.
> 
> Yes, sure. [PATCH v2 4/4] implements wrapping at 72 columns.

So you provide crappy formatted stuff first, just to reformat it at the
end. I'm missing the logic behind that.

Thanks,

	tglx

Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EE1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFFC2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAGUK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:10:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50228 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGUK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:10:58 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ggbE6-0002mC-2f; Mon, 07 Jan 2019 21:10:22 +0100
Date:   Mon, 7 Jan 2019 21:10:22 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org,
        Luca Abeni <lucabe72@gmail.com>
Subject: Re: [PATCH RT 10/13] drm/i915: disable tracing on -RT
Message-ID: <20190107201021.bzhewivla36iitbi@linutronix.de>
References: <20190107195252.599921907@goodmis.org>
 <20190107195333.594740538@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107195333.594740538@goodmis.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-07 14:53:02 [-0500], Steven Rostedt wrote:
> 4.14.87-rt50-rc1 stable review patch.
> If anyone has any objections, please let me know.
there is
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/drm-i915-skip-DRM_I915_LOW_LEVEL_TRACEPOINTS-with-NO.patch?h=linux-4.19.y-rt-patches

to address a build failure with CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS.

I know you are aware of that and that there is/was some discussion about
this gem. I would be happier if we could avoid complex code within a
tracepoint.

Sebastian

Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F843C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A9F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfANOqV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:46:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfANOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:46:20 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gj3Up-0006kj-TK; Mon, 14 Jan 2019 15:45:48 +0100
Date:   Mon, 14 Jan 2019 15:45:47 +0100
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "julia@ni.com" <julia@ni.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Korty <Joe.Korty@concurrent-rt.com>
Subject: Re: [ptrace, rt] erratic behaviour in PTRACE_SINGLESET on 4.13-rt
 and later.
Message-ID: <20190114144547.bgvkgv24g2odrek4@linutronix.de>
References: <20181119194619.GA32121@zipoli.concurrent-rt.com>
 <20181120122900.625b1d98@gandalf.local.home>
 <20181127085819.7e0865ee@tagon>
 <20181127151004.GB15742@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181127151004.GB15742@zipoli.concurrent-rt.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-27 15:10:07 [+0000], Joe Korty wrote:
> Hi Clark,
Hi Clark,

> No I don't, sorry.  I am attaching the LAG version, it is a few
> dozen lines shorter than the version I first sent out to the
> mailing list.

Did this make its way to rt-tests? I have some changes on top of it
while I was looking for the bug…

Sebastian

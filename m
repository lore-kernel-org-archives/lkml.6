Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC82C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D813821908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbeLULKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:10:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34425 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbeLULKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:10:03 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gaIgm-00080N-PZ; Fri, 21 Dec 2018 12:09:56 +0100
Date:   Fri, 21 Dec 2018 12:09:56 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julia Cartwright <julia@ni.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [ANNOUNCE] 4.9.146-rt125
Message-ID: <20181221110956.quje2nriylyq54xg@linutronix.de>
References: <20181221043607.GC15714@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181221043607.GC15714@jcartwri.amer.corp.natinst.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-21 04:36:08 [+0000], Julia Cartwright wrote:
> Hello RT Folks!
> 
> I'm pleased to announce the 4.9.146-rt125 stable release.

Thank you Julia.

> Apologies for an update to the 4.9-rt tree being way overdue.
> 
> This release is just an update to the new stable 4.9.146 version
> and no RT specific changes have been made.

Except that 4.9.115-rt94 has been also released in the meantime which
did contain some RT specific changes (for people which skipped the rc1
release).

Regarding the spin_lock backports for lockup on x86 as reported by
Daniel: The backports are part of the stable tree 4.9.147 and 4.14.90
which is currently out for review.

Sebastian

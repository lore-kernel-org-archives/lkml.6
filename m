Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C2BC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711B420827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711B420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeJ3WSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:18:36 -0400
Received: from mail.monom.org ([188.138.9.77]:56264 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbeJ3WSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:18:36 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 90108500A1F;
        Tue, 30 Oct 2018 14:25:07 +0100 (CET)
Received: from [127.0.0.1] (mail.monom.org [188.138.9.77])
        by mail.monom.org (Postfix) with ESMTPSA id 8930950051A;
        Tue, 30 Oct 2018 14:25:06 +0100 (CET)
Subject: Re: [ANNOUNCE] 4.4.162-rt175
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
References: <20181029200501.BECE75007F3@mail.monom.org>
Message-ID: <892f6f12-d8a9-2570-edff-ba077344bc63@monom.org>
Date:   Tue, 30 Oct 2018 14:25:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181029200501.BECE75007F3@mail.monom.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2018 21:04, Daniel Wagner wrote:
> Hello RT Folks!
> 
> I'm pleased to announce the 4.4.162-rt175 stable release.
> 
> This release is just an update to the new stable 4.4.120 version
> and no RT specific changes have been made.
> 
> This version still qspinlock enabled, because I wanted to update first
> to the last stable release and then resend the patch which drops back
> to ticket spinlocks.

I forgot to mention about the tagging/counting policy change. The
stable-rt maintainers have decided to use the same tagging/counting
strategy for all the stable-rt trees. If there is no merge conflict the
latest stable release is merged and tagged. All intermediates merge
commit and tag is not done anymore unless there is a conflict. The
conflict will be resolved and a merge commit with tag will be applied.

Thanks,
Daniel

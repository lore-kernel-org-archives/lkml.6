Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FD6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2E120875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2E120875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbeGWQx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387968AbeGWQx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:53:59 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C2D20852;
        Mon, 23 Jul 2018 15:52:07 +0000 (UTC)
Date:   Mon, 23 Jul 2018 11:52:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Changbin Du <changbin.du@intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Documentation: trace: improve probe documentation
Message-ID: <20180723115206.7f5e3ca8@gandalf.local.home>
In-Reply-To: <20180723092656.70333488@lwn.net>
References: <1531739158-31133-1-git-send-email-andreas.ziegler@fau.de>
        <20180723092656.70333488@lwn.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 09:26:56 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> On Mon, 16 Jul 2018 13:05:56 +0200
> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
> 
> > This series improves the documentation for uprobes and
> > kprobes.
> > 
> > The filename for enabling/disabling single events is 'enable',
> > not 'enabled'. kprobetrace.rst lists the files present in the
> > per-event directories but missed 'trigger' so far.  
> 
> I've applied the pair, thanks.
>

Thanks Jon. I was on vacation last week. Feel free to add:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

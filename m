Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE02ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C4C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C4C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbeGWQ2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:28:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:34778 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387831AbeGWQ2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:28:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EF2BF30A;
        Mon, 23 Jul 2018 15:26:57 +0000 (UTC)
Date:   Mon, 23 Jul 2018 09:26:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Changbin Du <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Documentation: trace: improve probe documentation
Message-ID: <20180723092656.70333488@lwn.net>
In-Reply-To: <1531739158-31133-1-git-send-email-andreas.ziegler@fau.de>
References: <1531739158-31133-1-git-send-email-andreas.ziegler@fau.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018 13:05:56 +0200
Andreas Ziegler <andreas.ziegler@fau.de> wrote:

> This series improves the documentation for uprobes and
> kprobes.
> 
> The filename for enabling/disabling single events is 'enable',
> not 'enabled'. kprobetrace.rst lists the files present in the
> per-event directories but missed 'trigger' so far.

I've applied the pair, thanks.

jon

Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73712C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A79621A0A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A79621A0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeHFOE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:04:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45074 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729775AbeHFOE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:04:59 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fme7Q-0004ba-DH; Mon, 06 Aug 2018 13:56:12 +0200
Date:   Mon, 6 Aug 2018 13:56:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     rt-users <linux-rt-users@vger.kernel.org>
Subject: [CFP] Real-Time Summit 2018 Call for Presentations
Message-ID: <alpine.DEB.2.21.1808061353140.1558@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a call for presentations for the 8th Real-Time Summit which
will be held in Edinburgh, UK, on October 25th, 2018. The event
follows the Embedded Linux Conference Europe 2018.

The Real-Time Summit is organized by the Linux Foundation Real-Time
Linux (RTL) collaborative project. The event is intended to gather
developers and users of the Real-Time preemption patch. The main
intent is to provide room for discussion between developers, tooling
experts and users.

If you are interested to present, please submit a proposal to
rt-cfp@linutronix.de before September 9th, 2018, at 23:59 EST. Please
provide a title, abstract describing the proposed talk (900 characters
maximum), short biography (900 characters maximum), and describe the
targeted audience (900 characters maximum). Please indicate the slot
length you are aiming for: The format is a single track with
presentation slots of 30 or 45 minutes length. The maximum
presentation time is 15 resp. 25 minutes and the remaining time is
reserved for discussion. The focus of this event is discussion.

We are welcoming presentations from both end users and developers, on
topics covering, but not limited to:

  - Real-time Linux development
  - Real-time Linux evaluation
  - Real-time Linux use cases (Success and failures)
  - Real-time Linux tooling (tracing, configuration, ...)

Those can cover recently available technologies, ongoing work and new
ideas. Please understand that this is not a place for presenting sales
and marketing pitches or to advertise technology which is not related
or not usable in the context of real-time Linux technology.

Further information about the event is available at the Real-Time
Summit 2018 wiki page:

https://wiki.linuxfoundation.org/realtime/events/rt-summit2018/start

On behalf of the RTL collaborative project

   Thomas Gleixner

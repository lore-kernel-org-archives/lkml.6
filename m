Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7156C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDB8214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDB8214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIZRVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:21:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:33545 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeIZRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:21:14 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1g57gT-0008Rr-Je; Wed, 26 Sep 2018 13:08:45 +0200
Received: from [2a02:1205:5001:74b0:7fcd:c249:e2e9:6650] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g57gT-0004jK-Cp; Wed, 26 Sep 2018 13:08:45 +0200
To:     netdev@vger.kernel.org, iovisor-dev@lists.iovisor.org,
        xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lpc-bpf@vger.kernel.org, alexei.starovoitov@gmail.com
From:   Daniel Borkmann <daniel@iogearbox.net>
Subject: Reminder: Linux Plumbers BPF micro-conference CFP
Message-ID: <9c500b84-00e7-c077-7f9c-a9cc01e1272e@iogearbox.net>
Date:   Wed, 26 Sep 2018 13:08:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24983/Wed Sep 26 04:39:15 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reminder: the submission deadline is still open for only 6 days,
please submit your proposals in time.

This is a call for proposals for the BPF micro-conference at the
Linux Plumbers Conference (LPC) 2018 which will be held in Vancouver,
Canada from the 13th to the 15th of November, co-located with the
Linux Kernel Summit.

The goal of the BPF micro-conference is to bring BPF developers
together to discuss topics around Linux kernel work related to
the BPF core infrastructure as well as its many subsystems under
tracing, networking, security, and BPF user space tooling. The
format of the micro-conference has a main focus on discussion,
therefore each accepted topic will provide a short 1-2 slide
introduction with subsequent discussion for the rest of the
allocated time slot. The expected time for one discussion slot is
approximately 15 min. The whole BPF micro-conference is a 3 hours
long session which will run on the third day of LPC (so that it
does not overlap with the LPC's Networking Track).

The BPF micro-conference is a community-driven event and open to
all LPC attendees, there is no additional registration required.

Please submit your discussion proposals to the LPC BPF micro-conference
organizers at:

	lpc-bpf@vger.kernel.org

Proposals must be submitted until October 1st, and submitters will
be notified of acceptance by October 5th. (Please note that proposals
must not be sent as html mail as they are otherwise dropped by vger.)

The format of the submission and many other details can be found at:

	http://vger.kernel.org/lpc-bpf.html

Looking forward to seeing you all in Vancouver!

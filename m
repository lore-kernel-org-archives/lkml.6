Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2FCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7F92177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7F92177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeHUSeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:34:05 -0400
Received: from www62.your-server.de ([213.133.104.62]:33602 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeHUSeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:34:05 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fs8LX-0008W8-9R; Tue, 21 Aug 2018 17:13:27 +0200
Received: from [178.197.248.16] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fs8Jg-000IGn-1Q; Tue, 21 Aug 2018 17:11:32 +0200
To:     netdev@vger.kernel.org, iovisor-dev@lists.iovisor.org,
        xdp-newbies@vger.kernel.org, containers@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     lpc-bpf@vger.kernel.org, alexei.starovoitov@gmail.com
From:   Daniel Borkmann <daniel@iogearbox.net>
Subject: Linux Plumbers BPF micro-conference CFP
Message-ID: <4e0793c9-2808-2a0b-c299-dc386d18a001@iogearbox.net>
Date:   Tue, 21 Aug 2018 17:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24862/Tue Aug 21 10:47:00 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

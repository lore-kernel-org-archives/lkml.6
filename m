Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1988AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E551B20869
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfA1Xyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:54:50 -0500
Received: from www62.your-server.de ([213.133.104.62]:49018 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfA1Xyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:54:50 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1goGjm-0001X5-Sw; Tue, 29 Jan 2019 00:54:46 +0100
Received: from [178.197.249.31] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1goGjm-000XRv-NZ; Tue, 29 Jan 2019 00:54:46 +0100
Subject: Re: [PATCH] bpf/core.c - silence warning messages
To:     valdis.kletnieks@vt.edu
Cc:     Song Liu <liu.song.a23@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <31468.1548648675@turing-police.cc.vt.edu>
 <CAPhsuW54z8ao4KOKG9ZjdXus6LTBH2qwAi8LgPFZ_qb_ObKsRg@mail.gmail.com>
 <3c8c866f-c665-ff82-a0ab-a4eafd28b20f@iogearbox.net>
 <10399.1548719293@turing-police.cc.vt.edu>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3a429bff-05e6-8333-99e9-ecd745a656ae@iogearbox.net>
Date:   Tue, 29 Jan 2019 00:54:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <10399.1548719293@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25339/Mon Jan 28 19:32:47 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/2019 12:48 AM, valdis.kletnieks@vt.edu wrote:
> On Tue, 29 Jan 2019 00:22:26 +0100, Daniel Borkmann said:
>> I think moving in separate file would be overkill, imho. However, lets get
>> the kdoc and prototype warning fixed.
> 
> I have a bunch of spare time at the moment, so the kdoc and prototype
> warnings are on my to-do list.

Great, thanks!

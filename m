Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701D8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B3C2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B3C2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeHQBfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 21:35:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:49384 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeHQBfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 21:35:19 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fqQqU-0007uO-Og; Fri, 17 Aug 2018 00:34:22 +0200
Received: from [178.197.249.25] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fqQqU-0009TI-IY; Fri, 17 Aug 2018 00:34:22 +0200
Subject: Re: [PATCH] tracing: Add SPDX License format to bpf_trace.c
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <20180816154817.6e8f0b93@gandalf.local.home>
 <20180816222056.2fddxbzpjox2for4@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1e3da13d-39fd-bb19-7e73-e53e118fe877@iogearbox.net>
Date:   Fri, 17 Aug 2018 00:34:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180816222056.2fddxbzpjox2for4@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24848/Thu Aug 16 18:48:15 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 12:20 AM, Alexei Starovoitov wrote:
> On Thu, Aug 16, 2018 at 03:48:17PM -0400, Steven Rostedt wrote:
>> [ Alexei and/or Daniel, I'm adding SPDX headers to the tracing
>>   directory. Can you ack this patch? Thanks ]
>>
>> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>>
>> Add the SPDX License header to ease license compliance management.
>>
>> Cc: Alexei Starovoitov <ast@plumgrid.com>
> 
> ohh. did you get a reply from that address? ;)
> 
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Also from my side:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2011-2015 PLUMgrid, http://plumgrid.com
  * Copyright (c) 2016 Facebook
  *

You probably also want to remove that single '*' line as well in your patch.

- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
  */

Thanks,
Daniel

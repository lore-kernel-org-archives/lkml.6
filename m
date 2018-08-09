Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA29DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D952098B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D952098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbeHIKsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:48:47 -0400
Received: from www62.your-server.de ([213.133.104.62]:33224 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeHIKsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:48:47 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fngFb-0007sU-9H; Thu, 09 Aug 2018 10:24:55 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fngFb-0003Tm-4F; Thu, 09 Aug 2018 10:24:55 +0200
Subject: Re: [PATCH bpf-next 0/4] Convert filter.txt to RST
To:     "Tobin C. Harding" <me@tobin.cc>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180809052328.27942-1-me@tobin.cc>
 <20180809060734.rtqqu4sexbwzuqmm@ast-mbp> <20180809072753.GF32374@eros>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <80bdc251-9f57-602f-6536-b34651684bb7@iogearbox.net>
Date:   Thu, 9 Aug 2018 10:24:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180809072753.GF32374@eros>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24825/Thu Aug  9 02:43:16 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 09:27 AM, Tobin C. Harding wrote:
> On Wed, Aug 08, 2018 at 11:07:35PM -0700, Alexei Starovoitov wrote:
>> On Thu, Aug 09, 2018 at 03:23:24PM +1000, Tobin C. Harding wrote:
>>>
>>> Daniel and Alexei, can I please have permission to add GPLv2+ to the BPF
>>> docs?
>>
>> kernel licensing is GPLv2 without +
> 
> According to process/license-rules.rst
> 
> 	    GPL-2.0+  :  GNU General Public License v2.0 or later

Not really, please see the first three paragraphs of process/license-rules.rst.
The COPYING file of the kernel says that it's 'v2' and not 'v2 or later',
unless otherwise _explicitly_ noted. Given that and given there is no other
specific note in filter.txt, it would mean it's v2-only due to that rule.

>> every file (including docs) can potentially have a different
>> compatible license, but since they were developed
>> implicitly under v2 only you would need to get a buy-in from
>> all contributors before making such change.
> 
> So if a file does not _explicitly_ state that it is under another
> licence it is ok to add GPLv2?
> 
> 
> thanks,
> Tobin.
> 


Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C73ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D0920834
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D0920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeGMVFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:05:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:33427 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbeGMVFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:05:24 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fe4zu-0002i2-PH; Fri, 13 Jul 2018 22:49:02 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fe4zu-00071c-IG; Fri, 13 Jul 2018 22:49:02 +0200
Subject: Re: [PATCH bpf-next v5 0/3] bpf: btf: print bpftool map data with btf
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Okash Khawaja <osk@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20180712030803.875913594@fb.com>
 <20180711203010.51bab0cf@cakuba.lan>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e938c861-b341-22f0-7e82-215a27e2b74f@iogearbox.net>
Date:   Fri, 13 Jul 2018 22:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180711203010.51bab0cf@cakuba.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24749/Fri Jul 13 14:56:11 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 05:30 AM, Jakub Kicinski wrote:
> On Wed, 11 Jul 2018 20:08:03 -0700, Okash Khawaja wrote:
>> Hi,
>>
>> Here are the changes from v4:
>>
>> patch 2:
>>
>> - sort headers in btf_dumper.c
>> - remove extra parentheses
>> - include asm/byteorder.h
>> - compile error when big and small endian bitfields macro undefined
> 
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Hmm, strange, by accident I just noticed that only your bpf fix ever made
it to patchwork, Okash.

  https://patchwork.ozlabs.org/project/netdev/list/?submitter=74458&state=*

Potentially because you've sent with attachments which got dropped on
the list?

Could you properly submit the series again, and retaining Jakub's Reviewed-by
tag to the patches?

Thanks,
Daniel

Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D847ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9C020664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9C020664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeKAHL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:11:27 -0400
Received: from www62.your-server.de ([213.133.104.62]:54210 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeKAHL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:11:27 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gHyhw-0003T4-Gb; Wed, 31 Oct 2018 23:11:24 +0100
Received: from [178.197.249.30] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gHyhw-000Kf1-9L; Wed, 31 Oct 2018 23:11:24 +0100
Subject: Re: [PATCH v2] kselftests/bpf: use ping6 as the default ipv6 ping
 binary if it exists
To:     Song Liu <liu.song.a23@gmail.com>, lizhijian@cn.fujitsu.com
Cc:     shuah@kernel.org, Networking <netdev@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <1540869355-13324-1-git-send-email-lizhijian@cn.fujitsu.com>
 <CAPhsuW4Bm2H7sV8xgzcD9s=9d_z1bpeEYbo2OMTTh9mcgmrC0w@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9244917c-05d7-113d-fef8-ff5251c8e0fe@iogearbox.net>
Date:   Wed, 31 Oct 2018 23:11:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4Bm2H7sV8xgzcD9s=9d_z1bpeEYbo2OMTTh9mcgmrC0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25079/Wed Oct 31 22:17:10 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2018 07:35 PM, Song Liu wrote:
> On Mon, Oct 29, 2018 at 7:35 PM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>>
>> ping binary on some distros doesn't support "ping -6" anymore.
>>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> 
> I think this should go bpf-next. Please resubmit when the bpf-next tree is open
> (after the merge window). Other than this:
> 
> Acked-by: Song Liu <songliubraving@fb.com>

Ok, applied to bpf tree, thanks. Given the fix, though not too urgent perhaps,
is small and isolated enough, I've applied it there.

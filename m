Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C855DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987CE20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987CE20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeKIUDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:03:15 -0500
Received: from www62.your-server.de ([213.133.104.62]:51014 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKIUDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:03:15 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gL3wU-000361-RT; Fri, 09 Nov 2018 11:23:10 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gL3wU-0007Zm-Kw; Fri, 09 Nov 2018 11:23:10 +0100
Subject: Re: [PATCH v2] kselftests/bpf: use ping6 as the default ipv6 ping
 binary when it exists
To:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Song Liu <songliubraving@fb.com>, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org,
        Philip Li <philip.li@intel.com>
References: <1541408268-11256-1-git-send-email-lizhijian@cn.fujitsu.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <46d1890b-26a0-7ca4-16e8-4704ec12692f@iogearbox.net>
Date:   Fri, 9 Nov 2018 11:23:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1541408268-11256-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25104/Fri Nov  9 07:02:31 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2018 09:57 AM, Li Zhijian wrote:
> At commit deee2cae27d1 ("kselftests/bpf: use ping6 as the default ipv6 ping
> binary if it exists"), it fixed similar issues for shell script, but it
> missed a same issue in the C code.
> 
> Fixes: 371e4fcc9d96 ("selftests/bpf: cgroup local storage-based network counters")
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

Applied to bpf, thanks Li!

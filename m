Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7B8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11F420883
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11F420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbeG0DLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:11:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:60669 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732005AbeG0DLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:11:24 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1firv8-0005cJ-PZ; Fri, 27 Jul 2018 03:51:54 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1firv8-0008sf-DG; Fri, 27 Jul 2018 03:51:54 +0200
Subject: Re: [PATCH bpf-next v2] samples/bpf: Add BTF build flags to Makefile
To:     Taeung Song <treeze.taeung@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>
References: <20180726101344.19351-1-treeze.taeung@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3dab4b13-284a-8784-1213-098a4915b37d@iogearbox.net>
Date:   Fri, 27 Jul 2018 03:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180726101344.19351-1-treeze.taeung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24786/Fri Jul 27 02:41:39 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 12:13 PM, Taeung Song wrote:
> To smoothly test BTF supported binary on samples/bpf,
> let samples/bpf/Makefile probe llc, pahole and
> llvm-objcopy for BPF support and use them
> like tools/testing/selftests/bpf/Makefile
> changed from the commit c0fa1b6c3efc ("bpf: btf:
>  Add BTF tests")
> 
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>

Applied to bpf-next, thanks Taeung!

Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B534C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2E320844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2E320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbeGYUTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:19:38 -0400
Received: from www62.your-server.de ([213.133.104.62]:49976 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbeGYUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:19:38 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiP7K-0007eM-HK; Wed, 25 Jul 2018 21:06:34 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiP7K-000UDO-7Z; Wed, 25 Jul 2018 21:06:34 +0200
Subject: Re: pahole + BTF was: Re: [Question] bpf: about a new
 'tools/bpf/bpf_dwarf2btf'
To:     Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        Thomas Girard <thomas.g.girard@free.fr>,
        Martin Cermak <mcermak@redhat.com>,
        linux-kernel@vger.kernel.org, acme@kernel.org
References: <47cfb90e-a9f4-8127-2b89-0e20d9fda2f0@gmail.com>
 <20180725175231.GA2121@redhat.com>
 <35663517-26e1-c2a2-1554-5dd90be2747f@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bc71a1d6-584c-0227-b972-4b2511c0546c@iogearbox.net>
Date:   Wed, 25 Jul 2018 21:06:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <35663517-26e1-c2a2-1554-5dd90be2747f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24782/Wed Jul 25 18:44:42 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 08:27 PM, Taeung Song wrote:
> On 07/26/2018 02:52 AM, Arnaldo Carvalho de Melo wrote:
[...]
>> BTW, Daniel, I just pushed to pahole's main repository at:
>>
>>    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
>>
>> with the Martin's BTF patch, so no need to pull from the github one,
>> I'll tag v1.12 and announce the release so that distro package
>> maintainers can update their packages.

Awesome, thanks so much Arnaldo!

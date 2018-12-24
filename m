Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7DAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CDC218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeLXABi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 19:01:38 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.189]:26084 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbeLXABi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 19:01:38 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 487E436794
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 18:01:37 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id bDgfgHYoA2PzObDgfg0dA4; Sun, 23 Dec 2018 18:01:37 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=60436 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gbDge-000gdN-LI; Sun, 23 Dec 2018 18:01:36 -0600
Subject: Re: [PATCH] net: core: Fix Spectre v1 vulnerability
To:     David Miller <davem@davemloft.net>, alexei.starovoitov@gmail.com
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181223041253.bxqru567rs32mecg@ast-mbp.dhcp.thefacebook.com>
 <e8343bfd-7846-a23b-b6c0-4b82218efdc0@embeddedor.com>
 <20181223055959.jlzbyd5ec55thiz7@ast-mbp.dhcp.thefacebook.com>
 <20181223.155838.90910738750758535.davem@davemloft.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <31dc24bd-ef31-6db4-d1b7-10f9d6619843@embeddedor.com>
Date:   Sun, 23 Dec 2018 18:01:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181223.155838.90910738750758535.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gbDge-000gdN-LI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:60436
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/18 5:58 PM, David Miller wrote:
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Date: Sat, 22 Dec 2018 22:00:00 -0800
> 
>> On Sat, Dec 22, 2018 at 11:03:31PM -0600, Gustavo A. R. Silva wrote:
>>>> I took another look at the following patches:
>>>> "net: core: Fix Spectre v1 vulnerability"
>>>> "nfc: af_nfc: Fix Spectre v1 vulnerability"
>>>> "can: af_can: Fix Spectre v1 vulnerability"
>>>> and I have to say that none of them are necessary.
>>>> I'm not sure whether there were other patches that pretend to fix spectre1.
>   ...
>> in other words there is no bug and there is no vulnerability,
>> but there is a 'policy' set by ... ?
>> So hence Nack to the policy and Nack to the patches.
> 
> I have to agree with Alexei after looking at all of this stuff one more
> time.
> 
> I'm reverting all of these changes.
> 

Yeah. That's fine with me.

Thanks
--
Gustavo

Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9870DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585FE2081F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585FE2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLHD5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 22:57:22 -0500
Received: from [110.188.70.11] ([110.188.70.11]:38773 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbeLHD5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 22:57:22 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id wB83usUP096598;
        Sat, 8 Dec 2018 11:56:54 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id wB83ulol005477;
        Sat, 8 Dec 2018 11:56:47 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from [172.20.20.131] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sat, 8 Dec 2018
 11:56:48 +0800
Subject: Re: [RFC PATCH RESEND] x86/cpu: Avoid endless loop to get the number
 of cache leaves
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1544081173-25059-1-git-send-email-puwen@hygon.cn>
 <20181206103736.GA3986@zn.tnic>
From:   Pu Wen <puwen@hygon.cn>
Message-ID: <4edaa34d-f05a-f957-8055-e7678c17c250@hygon.cn>
Date:   Sat, 8 Dec 2018 11:56:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181206103736.GA3986@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn wB83usUP096598
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/6 18:37, Borislav Petkov wrote:
 > Did you not see my reply to this last time?
 >
 > https://lkml.kernel.org/r/20181115172155.GB25056@zn.tnic

I'm sorry that there is something wrong with my mail filter. So I was
not notified about your reply for many days. :)

I just found your reply and replied to it.

Thx.

-- 
Regards,
Pu Wen

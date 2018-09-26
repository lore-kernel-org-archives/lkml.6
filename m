Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDD9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35A321508
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35A321508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeI0Euq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:50:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:49559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbeI0Eup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:50:45 -0400
Received: from [192.168.178.36] ([95.91.253.176]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvlWS-1fgFax0Pdc-017YPe; Thu, 27
 Sep 2018 00:35:34 +0200
Subject: Re: XBox One S controller, Bluetooth support (was Re: hid: microsoft:
 Add rumble support for Xbox One S controller)
To:     Bastien Nocera <hadess@hadess.net>, andrew.smirnov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        linux-input@vger.kernel.org
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
 <20180926125130.974-1-dollinger.florian@gmx.de>
 <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
 <b455a236b677c03f623ddbd5c28e602def439bc9.camel@hadess.net>
From:   Florian Dollinger <dollinger.florian@gmx.de>
Message-ID: <73a5acce-37cd-1ca4-333c-d02ce48fb644@gmx.de>
Date:   Thu, 27 Sep 2018 00:35:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <b455a236b677c03f623ddbd5c28e602def439bc9.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xnWmAY1OLPLvUeUsNDccjsgGJtLsK1FSJ5xTae++9ZpcQuXmuCR
 XTkEKuVdyW4UZeq70GhPmkQg/oUCTPyxNWagX9LjmPEy5ecYp3rdmRZe11vsof2qnAAb+Kz
 QAaNhnjWuoGeKjifPlAZ1/Gf4+/zgQkgvI0Z7l3TPmVNrDscecymj4Q5rk5yFSpAHfkeEEg
 a2j9F2uGW+LRAsKHibViw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Tg/CIq13afI=:oSN3JPyxIbm3Lr3qKELxMY
 DqWnnnet+7WG/cRT40LdCcePh6rns5qdwibA1KKM+4pFBPtxm9kw7lr9TTrcc/OG8xW2BkcJa
 I3gaOuy3ysdDPVPJY8JrU7KgYEbgMj5G2T1L7XXJ/lkOuItVxhaj2qbY0yJu5xeWS2++bO2u6
 CIRZPFQLFFZ3XGt8EXK59HKTBWCYXfe7CIdsMxwrfaHQk1KHTGg7FSd0l6tSMeYeoB8leWGE7
 +P3Z8XypZ7emijzE6Dr2KITqYZw2JuFpTMbBM9R5T8jd4/bQqPyRrwI6kZcDPZDRe53e7a7Y2
 3F5TfLMUItYaIbWvVkJXn9xPxqRSPqBCgHVwdY7lRsrXy7yxxi1Y7B81XkDWjbU3QlWX1PULy
 txPwpQldmLLm5QRh4t9OttqU7ItX1DZmVvH/5LO+6Mpjza5Q3U6OsdBleF+8u0LHsfVCL06eH
 74YYwmXBsTdTVCg3InONassX05fNBO183/4T10NGq7jujGDnXns8qzrBvfANm7t5VU49oOjoe
 AkSd9rQoGoTdQJbqyD5NmQCJqnIjQlky9mnYmt/1pxzWSKzIlevyZI23WL0cPhsnO5KW0dmCc
 rF4wRO4N6kQYcJ4mPoYypGjQaQAtwYdz7mB67QVcXvEEOVU7aC6MukIHCdEjkjfUdapWurr7L
 TgSGAWb2ZXFbeOgiPUbQLufn2hPC5C2kdrM6QoGE5txs07p7XI/7qxEAan0aNdSkBkD0KQ3Ya
 c7TxPFk243h+Pc8bXrAVM6dVMrFOhNCpB3MtoEW7oH+MqlRYzl7ArPyn1592vWrHS++UyXYNe
 WSfMu81X1zjQbibbecVEMauaa4q+DXPRCvEq2Q3M8ksiE3i+Ac=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For this patch, after speaking with the Bluetooth maintainers, we would
> need to:
> - add relevant btmon outputs before and after the patch in the commit
> message
> - remove the mention of "many devices" (if you've seen other devices
> with that problem in the wild, please mention them, otherwise mention
> that it's for "XBox One S" controllers, and clones)
> - run the patch against the "Profile Tuning Suite Tool" from the
> Bluetooth SIG. This requires a Windows laptop, and a piece of hardware
> from the Bluetooth SIG, see below.
> 
> The first 2 should be pretty easy to do, just send your patch using
> "git send-email" to the linux-bluetooth list (CC:ed), with the data
> attached.
> 
> For the qualification test, I was told Szymon has a test suite that he
> could use to double-check the tests. If not, I should be able to buy
> the adapter and run that test suite locally.
> 
> Cheers

Thanks, I will give it a try tomorrow (later) :)


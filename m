Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31E4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6797F208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6797F208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeJAVtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:49:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44784 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJAVty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:49:54 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1g6zrE-0005Sq-LD
        for linux-kernel@vger.kernel.org; Mon, 01 Oct 2018 15:11:36 +0000
Received: by mail-qt1-f199.google.com with SMTP id 1-v6so14067933qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 08:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BfrGIIIjeokzZ9xQ+i/KeBFbNOy2IBzkKyVL7eUg2jw=;
        b=DUMyom/NbOW7str6CD3K/02tzxTVbPoh+lYvGRLtFHjXChg5udGzi12SBm8+P4JaOR
         v/3tz9WI/Doa1c0ITfrBTrKvvRdNhivXfOdEVVqq+s2yksttZq7cj+YU3wtWPLFDEXIe
         1NBTrHtjgMUT2Bgio2ZprD60a/GYI+6q/u1L4M2wQOcurmzu+vRf34u3GzXwC0om2WZ6
         OodftqWf7+R09mYyuWrvpYy/DvkUWiY9S++keKdDHw21E1BIx0cD5QZzgjOtHrLhj5J+
         hM1uCcsaSNETcXG9KvSmVskTdVJ1RfHDrkdsVd7UPLidR8FT00yN2+hA0pMhC2nX6rHA
         9iUA==
X-Gm-Message-State: ABuFfoghPfK/5PHAaiQjC8TkOPEmTCbymHPesF8atjekl0wRwtUpKnU+
        z9XZoCIs7n5ML2zDQlIBkPwnsq9bHHsWNv9YLYG13tet56UkqmEU5vDE1RNz6OjuNNtXGsWEJom
        1Rybog/DGR2T4z+NAeKkatVYUa1gHPxovVek7IwEclg==
X-Received: by 2002:a37:895:: with SMTP id 143-v6mr8061106qki.99.1538406695889;
        Mon, 01 Oct 2018 08:11:35 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62S4kUfHlugHSyF8UD/PuZNDitj422UXYfRFuL6ur45hn5qYdKHrrcxkpfD9UoDGPcuLB32aw==
X-Received: by 2002:a37:895:: with SMTP id 143-v6mr8061091qki.99.1538406695673;
        Mon, 01 Oct 2018 08:11:35 -0700 (PDT)
Received: from [192.168.1.109] (201-43-221-124.dsl.telesp.net.br. [201.43.221.124])
        by smtp.gmail.com with ESMTPSA id u13-v6sm758028qtu.90.2018.10.01.08.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:11:34 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Change maintainer of genwqe
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     haver@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
        brking@linux.ibm.com, haver@linux.ibm.com, maurosr@linux.ibm.com
References: <1517836201-19362-1-git-send-email-maurosr@linux.vnet.ibm.com>
 <a90ca2a5-5d64-bb3a-babc-dc654725a062@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <a51e8b29-9aec-a5cf-8e33-46ae5eac1fd9@canonical.com>
Date:   Mon, 1 Oct 2018 12:11:30 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a90ca2a5-5d64-bb3a-babc-dc654725a062@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 11:13, Guilherme G. Piccoli wrote:
> On 05/02/2018 11:10, Mauro S. M. Rodrigues wrote:
>> Guilherme is no longer available to maintain the driver. I'll assume his
>> position for now on.
>>
>> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> 
> Thanks a lot Mauro!
> 
> Acked-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> 
> 
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b59a8cd..21ab6b9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5968,7 +5968,7 @@ F:	drivers/uio/uio_pci_generic.c
>>  
>>  GENWQE (IBM Generic Workqueue Card)
>>  M:	Frank Haverkamp <haver@linux.vnet.ibm.com>
>> -M:	Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>> +M:	Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
>>  S:	Supported
>>  F:	drivers/misc/genwqe/
>>  


Hi, I'd like to understand what is the status of this patch. Never got
merged it seems...why?

My old email wasn't valid anymore, so it's important to change it/remove
it from the MAINTAINERS file.

Thanks in advance,


Guilherme

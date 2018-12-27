Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF849C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 00:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7F8218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 00:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545871483;
	bh=ZYmP1T4qhzg6JaQfU9QkfoHFKICYGM776Tmo/B2bYRc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GDpeNNrISTV+R7YilN0UTmqRE3ZDNr+nuLLStUF4Qmj2NHJfxJhzHqZ2hmlQvFCMh
	 vBHG5MmjCAvCYK+6p1rgDkMRhBh+9pyeZrvun2LtmO9ATNY/mYDzkKSw7CYmq+bwbX
	 kUi5d3rTpgxRBkeqKF+hKV/WfvJj4fG1zSfsAh/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeL0Aom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 19:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbeL0Aol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 19:44:41 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74B4214D8;
        Thu, 27 Dec 2018 00:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545871481;
        bh=ZYmP1T4qhzg6JaQfU9QkfoHFKICYGM776Tmo/B2bYRc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cnway4Vw8clzYsGLMvLXp5/cMB3Tu4Yzdb5aWAYoqfor5BHyJ4pE/+Jx2FmoJsuKv
         7Dc/DKwaQWp5eocW13xmjKZJKuWwrgzhDSao4km3ERBtjhCPKq1/bKXQsnJvDJpUqj
         WNzPeD6SkAoByo+n5uGvCR8lmIkWurgSvSXozEXI=
Subject: Re: [PATCH V2] SelfTest: KVM: Drop Asserts for madvise
 MADV_NOHUGEPAGE failure
To:     Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        shuah <shuah@kernel.org>
References: <20181116115055.7415-1-ahmedsoliman0x666@gmail.com>
 <20181116125858.yujwx5xkpg2kgyxe@kamzik.brq.redhat.com>
 <CANBxJ=EeosO1EOfvQ6OFLps+D9ZQRBKTmByvcJ5r=h-4ahbekQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <218eb42a-ccbd-c454-e6f9-153f66c4478b@kernel.org>
Date:   Wed, 26 Dec 2018 17:44:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANBxJ=EeosO1EOfvQ6OFLps+D9ZQRBKTmByvcJ5r=h-4ahbekQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On 12/24/18 7:56 AM, Ahmed Soliman wrote:
> Kind reminder to merge my patch into next
> 
> thanks.
> 

I am assuming you will be picking this patch up. Please let me know if 
you want me to take it through kselftest tree.

thanks,
-- Shuah


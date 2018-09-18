Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625B3ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076DB20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076DB20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeIRQWv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:22:51 -0400
Received: from ozlabs.org ([203.11.71.1]:55973 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbeIRQWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:22:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42F0CC728vz9sCK;
        Tue, 18 Sep 2018 20:50:47 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/makefile: remove check on obsolete GCC versions
In-Reply-To: <1ede3510-df2a-183a-dd4b-3276041d8910@c-s.fr>
References: <82bbb913ffd8bdc040a012152ee968cd0c6ccf4e.1537218487.git.christophe.leroy@c-s.fr> <CACPK8XdeT_FF_PHjqOh3e18jDhsFOdECVDd+Z2vWt8pSk5damA@mail.gmail.com> <1ede3510-df2a-183a-dd4b-3276041d8910@c-s.fr>
Date:   Tue, 18 Sep 2018 20:50:44 +1000
Message-ID: <87va73axkr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 18/09/2018 à 07:48, Joel Stanley a écrit :
>> Hey Christophe,
>> 
>> On Tue, 18 Sep 2018 at 15:13, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>
>>> Since commit cafa0010cd51 ("Raise the minimum required gcc version
>>> to 4.6"), it is not possible to build kernel with GCC lower than 4.6
>>>
>>> This patch removes checkbin tests addressing older versions of GCC.
>> 
>> This is the same as Nick's patch:
>> 
>>   https://patchwork.ozlabs.org/patch/969624/
>> 
>
> Oops, thanks, I missed that.
>
> And even before Nick's, there is this one 
> https://patchwork.ozlabs.org/patch/962319/
>
> So I missed twice :(

Haha, I missed that one too.

Everyone loves deleting code ;)

I have Nick's patch queued.

cheers

Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771F223DEE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771F223DEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeGFONk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:13:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28821 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753798AbeGFONj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:13:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41McCL2t7zz9ttwZ;
        Fri,  6 Jul 2018 16:13:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FtMMSnNdsNmP; Fri,  6 Jul 2018 16:13:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41McCL2Fthz9ttwX;
        Fri,  6 Jul 2018 16:13:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AAB068B7E6;
        Fri,  6 Jul 2018 16:13:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9l0v018cHGk7; Fri,  6 Jul 2018 16:13:37 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8371D8B7E5;
        Fri,  6 Jul 2018 16:13:37 +0200 (CEST)
Subject: Re: [PATCH V2 00/10] KASan ppc64 support
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGyMBnGJyBCoq2n9YSgC73GXr9-w3SjCTVdfz++drzOVGw@mail.gmail.com>
 <87k2sic6pw.fsf@linux.vnet.ibm.com>
 <7d459964-ce68-db1c-3d28-ae206d5ebdb0@c-s.fr>
 <87h8lch2t2.fsf@linux.vnet.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <22bcc719-daeb-4e82-9e9e-e8a82ad72a1e@c-s.fr>
Date:   Fri, 6 Jul 2018 16:13:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <87h8lch2t2.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/07/2018 à 16:11, Aneesh Kumar K.V a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> 
>> Hi Aneesh,
>>
>> Are you still working on support for KASan for ppc64 ?
>>
> 
> Haven't got time to work on this. The hash memory layout makes it
> a bit complicated to implement this.
> 

Ok, maybe would be easier to start with nohash.

Is there some literature somewhere about what an arch has to implement 
to use KAsan ?

Thanks,
Christophe

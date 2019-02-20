Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1FDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AE620851
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfBTWjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:39:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34084 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfBTWjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:39:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id w4so29365716qtc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 14:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ttnIK6/QFjYzU/D0HL40M0ZLJn988iAXS4P3Ni+3XTM=;
        b=nKs5yKtCgeGFYHju4ejDE9OZ+AFWMHxFEHCbjL0/POoX1ZYVtomAx3hjbe1jxRF54e
         KgBltsdXzalv3etv7J84c92kWeGgw4mCc7oXSN8/Ko9XtBFmHboKjX2whLLRV8Ooy4dH
         oFSSPwulYBXTsJf8IpdmdxeOiaz9Jzy0VkGoEeEtglneN6u6WeJvbvo2TP+P9jXA+Dcr
         iclNq9bgGSoKHUODQj4tlmeU0e6nC76yn9m43thmmTlVtM2xYjNyiiKC3ARweXr6wn48
         5aJz9Mg56nq/zrfvTZ92L2DujTaWxOb3i9QSHSFfT81l+n4KfmThwdf9RJHHSoka3jVI
         0guQ==
X-Gm-Message-State: AHQUAualcVhoAsi9Af/KfgDQPxDO05mXEMMpvvy/EB4AM6WSQq4+CQCx
        xlb6DS6H2ZKj932BUBWxkyzFEjzmhG0=
X-Google-Smtp-Source: AHgI3IaMcCyp5pbV1sONuz1OE54AJY5+2AxCVfFjU1uZ1GTb42Hm6M+VeK9FbjaUd52lPd6bnLgffQ==
X-Received: by 2002:ac8:266d:: with SMTP id v42mr28676858qtv.116.1550702344991;
        Wed, 20 Feb 2019 14:39:04 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id j11sm16616920qtk.26.2019.02.20.14.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 14:39:04 -0800 (PST)
Date:   Wed, 20 Feb 2019 15:39:03 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Morris <jmorris@namei.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] MAINTAINERS: add linux-security-module mailing list to
 TPM drivers
Message-ID: <20190220223903.dusft4bbd33hu2qi@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20190220035846.6272-1-jsnitsel@redhat.com>
 <20190220070413.GB23027@linux.intel.com>
 <20190220140357.5vbepgmexso3jc6d@cantor>
 <20190220150445.GA4794@linux.intel.com>
 <alpine.LRH.2.21.1902210747510.1411@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1902210747510.1411@namei.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 21 19, James Morris wrote:
>On Wed, 20 Feb 2019, Jarkko Sakkinen wrote:
>
>> > being cc'd to linux-security-module? Looking back at
>> > recent patches, it looked like it was a general request.
>> > If it is, I'll be more likely to remember if get_maintainers.pl
>> > brings it up. :)
>>
>> I'm all open here. Not sure which practices apply to IMA. I kind of tend
>> to dilate to question does it make sense to CC to LSM for two reasons:
>>
>> 1. I think the original reason was that tpmdd mailing list was small.
>> Now with the new linux-integrity mailing list up and running there is
>> more eyes looking at the code. And more importantly the people are
>> subscribed who use TPM for something, like IMA developers.
>> 2. I don't remember ever reading within the time that I've been
>> maintaining even a single comment from anyone that works with LSM's. The
>> value of CC'ing there is not very significant, which means that most of
>> the time the TPM traffic is just noise on that list.
>
>Sounds about right, there used to be more security folk on LSM and not as
>many on the TPM list, but the new integrity list works well for TPM now.
>
>
>-- 
>James Morris
><jmorris@namei.org>
>

Okay. Ignore this patch then.

Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A10DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5566C20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfBTOEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:04:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41788 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBTOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:04:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id y15so552268qki.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 06:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TBEtLBmZh3NK/4fVp4zz7mJX2eX1tQB/Q+BEGy+bNlE=;
        b=LqIn4bY2IsPlZ2Y7jQlgcmZgMHTBimsaaCECBSGQwIiaR7g6A902A0si8GjtHuvrJW
         PUuXeeL6QPVR3enrjquQGFe9zLF0YibeVUVwBFXPWQERyt9mL/cZDFpRujGPYrUR8y6p
         qn8Xumg9ngrvj/9yriYWRNmVhD5jzRUPmweha63Nw0q7tS0UDH8jp6mwD3bIkPgndExP
         Vh9VEBpO66sCjVPCRlAJrfF5qTcEx/fAshxf2PPJdHepOe5gVGDMxs6tvKWCwC3+AEDk
         zj7GKGjst4+N0wDnBsGiA9fl5qp5UHwGy+8wPHgcEvEGD8nvW6/M6I6pEctwV7dKyQBU
         oY6A==
X-Gm-Message-State: AHQUAubL3Tu+y3yLBvknSBvrs9Vg0MCbU7Js50UU4sGq+Uig2pyl9Q0c
        WWolvO1JZ24Od2i4ONap4iD0Hg==
X-Google-Smtp-Source: AHgI3Ibi1y+ZU05BEMC9exJOELXs5Jc5z6ZxuHuJohOLy/e4n79vnAoiNrhtlMY4cfdI106VOi1VZg==
X-Received: by 2002:a37:4a4d:: with SMTP id x74mr24750550qka.61.1550671439067;
        Wed, 20 Feb 2019 06:03:59 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id b83sm6901303qkg.12.2019.02.20.06.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 06:03:58 -0800 (PST)
Date:   Wed, 20 Feb 2019 07:03:57 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] MAINTAINERS: add linux-security-module mailing list to
 TPM drivers
Message-ID: <20190220140357.5vbepgmexso3jc6d@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jmorris@namei.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20190220035846.6272-1-jsnitsel@redhat.com>
 <20190220070413.GB23027@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190220070413.GB23027@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Feb 20 19, Jarkko Sakkinen wrote:
>On Tue, Feb 19, 2019 at 08:58:46PM -0700, Jerry Snitselaar wrote:
>> I've seen requests to add linux-security-module to tpm patch
>> submissions a couple of times recently, so just add the list
>> to MAINTAINERS so get_maintainers.pl will mention it.
>>
>> Cc: Peter Huewe <peterhuewe@gmx.de>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>I guess James should say something about this.
>
>/Jarkko

Sorry, I meant to add James as well.

Maybe this isn't needed. Do you only want certain patches
being cc'd to linux-security-module? Looking back at
recent patches, it looked like it was a general request.
If it is, I'll be more likely to remember if get_maintainers.pl
brings it up. :)

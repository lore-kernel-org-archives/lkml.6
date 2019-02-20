Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4104FC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E7C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550655711;
	bh=ByzLbcUcmSF3faEyYikSKFWJ858JBmNi+gUQLh8XMn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2WkzHt1ClVzUF44L8MzXLBTAXiKGPPBdH6aX1TfbaTi8pHguErCijymZmwU1+VL0p
	 iqKsxIFSFfIAYJ9d2y/Qe7fTl/4Od5NwwE1zThm/5oXKJmhYtoLNK/iIhK8PEgeopY
	 FFD5SiOfG/mVyVqHyATJ2WSJUv29PlYJBu6N9sug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBTJlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfBTJlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:41:49 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B432089F;
        Wed, 20 Feb 2019 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550655708;
        bh=ByzLbcUcmSF3faEyYikSKFWJ858JBmNi+gUQLh8XMn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k7a9BBvleNSL4T7JuNjNLgoi4p3xYsIRgoawPlm08ODqsVE/abSOHGr90IU23oGnc
         WM/1Q7xGl464CRiHEtPHeDyu+6hwN26+oXN047Prbsb9irOf9s1eeoRXI4iAN07afY
         dcnfC7uUcT8vVU1u7c+Eao/yBpKKZ2RKlcrYCQg4=
Date:   Wed, 20 Feb 2019 09:41:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, matt.ranostay@konsulko.com
Subject: Re: [PATCH 0/5] iio:potentiostat:lmp91000: Adjust codestyle, and
 minor cleanup changes
Message-ID: <20190220094140.0f2ad613@archlinux>
In-Reply-To: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 14:22:31 -0300
Lucas Oshiro <lucasseikioshiro@gmail.com> wrote:

> Hi,
> 
> We solved some checkpath.el CHECKs and WARNINGs. We also inverted the arms of
> an if statement, in order to make the code smaller as the else statement was
> supressed. We added a missing '\n' on a dev_err message.

Please try to identify the original author.  Matt is still definitely
about, and he is obviously likely to be able to provide the most detailed
review of changes to this driver.

Thanks,

Jonathan

> 
> Lucas Oshiro (5):
>   iio:potentiostat:lmp91000: remove unnecessary parentheses
>   iio:potentiostat:lmp91000: insert braces around if arms
>   iio:potentiostat:lmp91000: reduce line width and remove blank line
>   iio:potentiostat:lmp91000: invert if statement
>   iio:potentiostat:lmp91000: add '\n' on dev_err
> 
>  drivers/iio/potentiostat/lmp91000.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 


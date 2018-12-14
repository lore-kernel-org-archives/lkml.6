Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99458C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D28D206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbeLNPLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:11:54 -0500
Received: from mail.ltec.ch ([95.143.48.181]:60494 "EHLO mail.ltec.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbeLNPLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:11:52 -0500
Received: from nebula.ltec ([172.27.11.2] helo=[172.27.11.32])
        by mail.ltec.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <fb@ltec.ch>)
        id 1gXp80-00035N-6c; Fri, 14 Dec 2018 16:11:48 +0100
Subject: Re: [PATCH] ARM: dts: am33xx: Remove unnecessary properties
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        bcousson@baylibre.com, mpfj@newflow.co.uk, mark.rutland@arm.com,
        robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
References: <20181210132448.7865-1-fb@ltec.ch>
 <20181211163618.GU6707@atomide.com> <20181211164336.GV6707@atomide.com>
From:   Felix Brack <fb@ltec.ch>
Message-ID: <89710fa1-38a9-1628-0651-003332780483@ltec.ch>
Date:   Fri, 14 Dec 2018 16:11:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181211164336.GV6707@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11.12.2018 17:43, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [181211 16:36]:
>> * Felix Brack <fb@ltec.ch> [181210 05:25]:
>>> Remove the unnecessary properties #address-cells and #size-cells
>>> of node pinmux as there are no child-nodes with property reg.
>>
>> Applying into omap-for-v4.21/dt thanks.
> 
> Actually this currently conflicts with the pending
> am33xx l4 ti-sysc changes, so let's wait on this
> one to avoid causing merge conflicts between
> branches.
>
Okay, I see. The changes introduced by my patch would then affect the
new file am33xx-l4.dtsi instead of am33xx.dtsi

> So dropping for now.
>
Will you "apply" my patch once the am33xx l4 ti-sysc changes are applied
or do you expect me to send V2 patch (to be applied to the new
am33xx-l4.dtsi) ?

regards, Felix

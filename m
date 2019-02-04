Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F11C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5C02082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="bSTTpxhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfBDM1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:27:17 -0500
Received: from smtpcmd14161.aruba.it ([62.149.156.161]:42980 "EHLO
        smtpcmd14161.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfBDM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:27:17 -0500
Received: from [192.168.1.32] ([93.146.66.165])
        by smtpcmd14.ad.aruba.it with bizsmtp
        id YcTF1z00R3Zw7e501cTG3z; Mon, 04 Feb 2019 13:27:16 +0100
Subject: Re: [PATCH v15 3/3] pps: pps-gpio pps-echo implementation
To:     Tom Burkart <tom@aussec.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Martins <rasm@fe.up.pt>,
        James Nuss <jamesnuss@nanometrics.ca>,
        Lukas Senger <lukas@fridolin.com>
References: <20190202105724.4743-1-tom@aussec.com>
 <20190202105724.4743-2-tom@aussec.com> <20190202105724.4743-3-tom@aussec.com>
 <20190202105724.4743-4-tom@aussec.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <bf4a8827-1758-4326-371c-8edd06e509cd@enneenne.com>
Date:   Mon, 4 Feb 2019 13:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190202105724.4743-4-tom@aussec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1549283236; bh=/g0N1pJ8ECE1ugwU5dX7OmPo7VlaSiPTN8yH4wRCd6I=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=bSTTpxhIxOL6G6O/9gosQwEdLy3ygGs11Z4P51YwmGrBokULYq1Id932cRJuB0z+G
         quK1s3SKF0/GokIOMj3EGC/ROgth6VnadjinDJ2TWcJhDs9GsVhW3B+I80HmtA8RsY
         9xRv6bImKaMmaK3+wJDEeNHbpdi9PX6yy3B5JbaeZhloqAxsg15m3e4/+4ry5GyGxh
         8/xUy0bmg0yLpzwpjByDsB+VLVMVRLXyxZtg8OpM3hGCopZDiYopXNxQFZZiI5O47i
         BlWpw0Nr4gG7s6+w3tlt4hOreiNqa0735uDX3sv5rzWCNq5CpSDLtLZqRDnGfnlDMX
         jV1VNq/OfUhDw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2019 11:57, Tom Burkart wrote:
> This patch implements the pps echo functionality for pps-gpio, that
> sysfs claims is available already.
> 
> Configuration is done via device tree bindings.
> 
> This patch was originally written by Lukas Senger as part of a masters
> thesis project and modified for inclusion into the linux kernel by Tom
> Burkart.
> 
> Signed-off-by: Lukas Senger <lukas@fridolin.com>
> Signed-off-by: Tom Burkart <tom@aussec.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

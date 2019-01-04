Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5ACC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1761C218E0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="BxLeBr1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfADRPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:15:12 -0500
Received: from smtpcmd13146.aruba.it ([62.149.156.146]:43806 "EHLO
        smtpcmd13146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfADRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:15:11 -0500
Received: from [192.168.188.46] ([93.34.66.13])
        by smtpcmd13.ad.aruba.it with bizsmtp
        id LH811z00A0H9oKh01H83D3; Fri, 04 Jan 2019 18:08:10 +0100
Subject: Re: [PATCH v14 2/3] dt-bindings: pps: pps-gpio PPS ECHO
 implementation
To:     Tom Burkart <tom@aussec.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     devicetree@vger.kernel.org, Ricardo Martins <rasm@fe.up.pt>,
        James Nuss <jamesnuss@nanometrics.ca>,
        Lukas Senger <lukas@fridolin.com>
References: <20181230083333.27210-1-tom@aussec.com>
 <20181230083333.27210-2-tom@aussec.com>
 <20181230083333.27210-3-tom@aussec.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <e23a0bfc-ab47-bdc1-7d32-d04ea5a250fd@enneenne.com>
Date:   Fri, 4 Jan 2019 18:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181230083333.27210-3-tom@aussec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1546621690; bh=G23zYhk5x5GC05r6XonOoArESJjzrtlQyyJVKwLFimM=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=BxLeBr1Iku69/nzMbEG87czKJXSdI0W/NvK040Nfv70qvZZvc42+Bw1TWq3eKmbFz
         tR/EuIWYgTtNV2EN4KkQLYF09cX638KbdutK/DL4EnWYkCXE3fLAIFcOy20OzR7GCp
         YDphJSrByORJSi/uzL2EdN2D/DD7jTTaKItBsdA7SNqWBUppMXInruVSe+9epxDB9V
         jVfcw9eAEUYpytGL35uzIEkHjiFFhlC5EcVk1d5+V/7uIWo1TZM/KOEFv/upYz2INo
         s750DnuOYErGkYCakt9r6V6C9IRWnNDXW64Kt3fgyhZHMhkvBznT+Fe23g4FiA2U5J
         QbC2LSlOFeWgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2018 09:33, Tom Burkart wrote:
> This patch implements the device tree binding changes required for the
> pps echo functionality for pps-gpio, that sysfs claims is available
> already.
> 
> This patch was originally written by Lukas Senger as part of a masters
> thesis project and modified for inclusion into the linux kernel by Tom
> Burkart.

I think this patch it's OK but I'm asking to myself if it should be merged with 
next one... logically it describes what patch 3/3 does so why do we keep them 
separated?

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

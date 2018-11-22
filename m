Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B94BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3198F208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3198F208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eclipso.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393058AbeKWHAv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:00:51 -0500
Received: from mail.eclipso.de ([217.69.254.104]:56811 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732806AbeKWHAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:00:51 -0500
Received: from roadrunner.suse (p5B318127.dip0.t-ipconnect.de [91.49.129.39])
        by mail.eclipso.de with ESMTPS id 4D3F4B85
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 21:19:52 +0100 (CET)
X-ESMTP-Authenticated-User: 0001F234
From:   stakanov <stakanov@eclipso.eu>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
Date:   Thu, 22 Nov 2018 21:19:49 +0100
Message-ID: <12757009.r0OKxgvFl0@roadrunner.suse>
In-Reply-To: <20181122180611.2e7f1123@coco.lan>
References: <4e0356d6303c128a3e6d0bcc453ba1be@mail.eclipso.de> <2836654.gWKGMNFOG2@roadrunner.suse> <20181122180611.2e7f1123@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mauro. 

Thank you so much, for this fast reply and especially for the detailed 
indications. I expected to have a lack of knowledge. 

Well,  I am replying to the question as of below: (for convenience I did cut 
the before text, if you deem it useful for the list I can then correct that in 
the next posts).

In data giovedì 22 novembre 2018 21:06:11 CET, Mauro Carvalho Chehab ha 
scritto:
> Are you sure that the difference is just the Kernel version? Perhaps you
> also updated some other package.

To be clear: I had the same system(!) with all three kernel 4.18.15-1, 4.19.1  
(when the problem did arise) and 4.20.2 rc3 from Takashi's repo) installed. 

In this very configuration: if one booted in 4.18 (that is in perfect parity 
with all other packages) the card worked. 4.19.1 no. And the last kernel the 
same. So whatever might be different, forcefully it has to be in the kernel. 
(Which is not really a problem if I manage to make it work, so settings will 
be known to others or, if not, we will find out what is different, and all 
will be happy. As you see I am still optimist).  
I will proceed as indicated and report back here tomorrow. 

Regards. 




_________________________________________________________________
________________________________________________________
Ihre E-Mail-Postfächer sicher & zentral an einem Ort. Jetzt wechseln und alte E-Mail-Adresse mitnehmen! https://www.eclipso.de



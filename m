Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30012C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC3520823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC3520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eclipso.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeKTJp7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:45:59 -0500
Received: from mail.eclipso.de ([217.69.254.104]:57660 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725722AbeKTJp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:45:59 -0500
Received: from roadrunner.suse (p5B318D4A.dip0.t-ipconnect.de [91.49.141.74])
        by mail.eclipso.de with ESMTPS id 431EB526
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:19:56 +0100 (CET)
X-ESMTP-Authenticated-User: 0001F234
From:   stakanov <stakanov@eclipso.eu>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
Date:   Tue, 20 Nov 2018 00:19:54 +0100
Message-ID: <1837109.xExTbI5ikD@roadrunner.suse>
In-Reply-To: <20181119210845.38072faf@coco.lan>
References: <s5hbm6l5cdi.wl-tiwai@suse.de> <2988162.jBOhpiBzca@roadrunner.suse> <20181119210845.38072faf@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In data martedì 20 novembre 2018 00:08:45 CET, Mauro Carvalho Chehab ha 
scritto:
>  uname -a
> 
> > Linux silversurfer 4.20.0-rc3-1.g7e16618-default #1 SMP PREEMPT Mon Nov 19
> > 18:54:15 UTC 2018 (7e16618) x86_64 x86_64 x86_64 GNU/Linux

 uname -a         
> Linux silversurfer 4.20.0-rc3-1.g7e16618-default #1 SMP PREEMPT Mon Nov 19 
> 18:54:15 UTC 2018 (7e16618) x86_64 x86_64 x86_64 GNU/Linux

from https://download.opensuse.org/repositories/home:/tiwai:/bsc1116374/
standard/x86_64/

So I booted this one, should be the right one. 
sudo dmesg | grep -i b2c2   should give these additional messages? 

If Takashi is still around, he could confirm. 



_________________________________________________________________
________________________________________________________
Ihre E-Mail-Postfächer sicher & zentral an einem Ort. Jetzt wechseln und alte E-Mail-Adresse mitnehmen! https://www.eclipso.de



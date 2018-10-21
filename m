Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE37ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 06:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BDA2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 06:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BDA2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeJUOcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 10:32:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeJUOcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 10:32:48 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gE75F-0001Gk-Cz; Sun, 21 Oct 2018 08:19:29 +0200
Date:   Sun, 21 Oct 2018 08:19:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
cc:     Tim.Bird@sony.com, gregkh@linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org, mishi@linux.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the contact
 email address
In-Reply-To: <20181021011348.564a3fe4@alans-desktop>
Message-ID: <alpine.DEB.2.21.1810210817470.1651@nanos.tec.linutronix.de>
References: <20181020134908.GA32218@kroah.com>        <20181020135118.GG32218@kroah.com>        <20181020192845.48b8b860@alans-desktop>        <ECADFF3FD767C149AD96A924E7EA6EAF80528627@USCULXMSG01.am.sony.com> <20181021011348.564a3fe4@alans-desktop>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Oct 2018, Alan Cox wrote:
> 
> I don't see it specifically stating that 'If someone is offensive at a
> kernel summit we are going to refuse to listen'

Kernel summit or Maintainer summit is covered by the CoC of the conference
it is attached to.

Thanks,

	tglx

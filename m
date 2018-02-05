Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeBELeO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:34:14 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35051 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750949AbeBELeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:34:05 -0500
X-ME-Sender: <xms:LEF4WsYBMZHn1aPvnlNu3ryH5VAyJ16dofN1xQr2Jvoeiw7lDvFjSQ>
Date: Mon, 5 Feb 2018 09:34:00 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Matthew Thode <mthode@mthode.org>
Cc: David Herrmann <dh.herrmann@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: suppress warning about palm
 detection
Message-ID: <20180205113400.qpqdkpv5bbvdwg22@khazad-dum.debian.net>
References: <20180112110445.1876-1-dh.herrmann@gmail.com>
 <CAHp75Vc66ZfRmOoOKJRODpV0mS2aZru=b-r0cr8SKYH=hm+W6Q@mail.gmail.com>
 <CANq1E4RGo091oaG=0owKVfxOV8wR2qQ=nXfXzZsRxg6Q7_C8zw@mail.gmail.com>
 <20180113063309.iryfhufpilas3jnf@mthode.org>
 <20180205050116.isaz6pmgsquzjmqr@mthode.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205050116.isaz6pmgsquzjmqr@mthode.org>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm fine with a signed-off-by or tested-by or suggested-by.  There is a
> > spelling mistake though, 'hoveres' should be hovers.
> 
> Is there anything else I can do here?  I'm not sure any of us have the
> ability to find out what lenovo actualy wants this for.

I have already acked the patch, so Darren or Andy should pick it up
sooner or later for merging into the subsystem tree...

But if you wouldn't mind doing so, you could send a V2 with all acks,
tested-by/suggested-by/whatever added, as well as that minor spelling
mistake correction...  I am not sure this is necessary, though.

Andy, Daren?

-- 
  Henrique Holschuh

Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C509C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B997208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B997208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=compro.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeJASyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:54:14 -0400
Received: from smtp89.ord1c.emailsrvr.com ([108.166.43.89]:33695 "EHLO
        smtp89.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728979AbeJASyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:54:14 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2018 14:54:13 EDT
Received: from smtp20.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp20.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 94464E0329;
        Mon,  1 Oct 2018 08:09:49 -0400 (EDT)
X-SMTPDoctor-Processed: csmtpprox beta
Received: from smtp20.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp20.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 8DF3BE032D;
        Mon,  1 Oct 2018 08:09:49 -0400 (EDT)
X-Auth-ID: markh@compro.net
Received: by smtp20.relay.ord1c.emailsrvr.com (Authenticated sender: markh-AT-compro.net) with ESMTPSA id E3372E0329;
        Mon,  1 Oct 2018 08:09:48 -0400 (EDT)
X-Sender-Id: markh@compro.net
Received: from [10.15.15.121] ([UNAVAILABLE]. [97.68.168.98])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 01 Oct 2018 08:09:49 -0400
Reply-To: markh@compro.net
Subject: Re: [PATCH v3] staging: dgnc: Fix Kconfig help header and text
To:     Lidza Louina <lidza.louina@gmail.com>,
        Sehro Rautenkranz <sehro@sehro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <59f16a7e-4221-73e0-cf6e-3461717be318@infradead.org>
 <20180925234159.22547-1-sehro@sehro.org>
 <CA+t4uCMAgpNtpdLfxNY_cmx7WONKOYjiaTBDGRNd+7H_GUdRAA@mail.gmail.com>
From:   Mark Hounschell <markh@compro.net>
Organization: Compro Computer Svcs.
Message-ID: <cdd97ca9-68c8-3a5e-faa1-d19cd5fe93a7@compro.net>
Date:   Mon, 1 Oct 2018 08:09:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CA+t4uCMAgpNtpdLfxNY_cmx7WONKOYjiaTBDGRNd+7H_GUdRAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/18 3:59 PM, Lidza Louina wrote:
> I haven't done work on this driver in a long time. I looked up the 
> devices, and they seem to already have an existing Linux driver: 
> https://www.digi.com/products/usb-and-serial-connectivity/serial-cards/digineo and 
> https://www.digi.com/support/productdetail?pid=1694
> 
> I've contacted the company to see if the driver is still needed in 
> staging. I'll send an update once they get back to me.
> 
> Lidza
> 

Good luck with that. Digi obsoleted ALL their PCI serial cards several 
months ago. They would not even respond to requests from me to include 
their firmware for their PCI dgap cards into the kernel firmware 
package. The card for the dgnc driver is a pci-e card that may still be 
supported by them however. Also there does appear to be an already in 
kernel driver for these "PCI-e" cards too. It actually works as I have a 
couple of these cards. The module name is "jsm".


03:00.0 Serial controller: Digi International Device 00f0 (rev 02) 
(prog-if 02 [16550])
         Subsystem: Digi International Device 00f0
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin A routed to IRQ 29
         Region 0: Memory at f7200000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: jsm
         Kernel modules: jsm


Regards
Mark

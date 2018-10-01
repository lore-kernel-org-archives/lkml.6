Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197B8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90A2206B5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90A2206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=compro.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJBAZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:25:42 -0400
Received: from smtp121.ord1d.emailsrvr.com ([184.106.54.121]:38161 "EHLO
        smtp121.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbeJBAZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:25:41 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2018 20:25:40 EDT
Received: from smtp8.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp8.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 288E4C04FD;
        Mon,  1 Oct 2018 13:38:44 -0400 (EDT)
X-SMTPDoctor-Processed: csmtpprox beta
Received: from smtp8.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp8.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 204F6C0583;
        Mon,  1 Oct 2018 13:38:44 -0400 (EDT)
X-Auth-ID: markh@compro.net
Received: by smtp8.relay.ord1d.emailsrvr.com (Authenticated sender: markh-AT-compro.net) with ESMTPSA id 8F932C04FD;
        Mon,  1 Oct 2018 13:38:43 -0400 (EDT)
X-Sender-Id: markh@compro.net
Received: from [10.15.15.121] ([UNAVAILABLE]. [97.68.168.98])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 01 Oct 2018 13:38:44 -0400
Reply-To: markh@compro.net
Subject: Re: [PATCH v3] staging: dgnc: Fix Kconfig help header and text
To:     Lidza Louina <lidza.louina@gmail.com>
Cc:     Sehro Rautenkranz <sehro@sehro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <59f16a7e-4221-73e0-cf6e-3461717be318@infradead.org>
 <20180925234159.22547-1-sehro@sehro.org>
 <CA+t4uCMAgpNtpdLfxNY_cmx7WONKOYjiaTBDGRNd+7H_GUdRAA@mail.gmail.com>
 <cdd97ca9-68c8-3a5e-faa1-d19cd5fe93a7@compro.net>
 <CA+t4uCPFZSTjyN-Wd3ppOp-edAXfSSTTdT8uab+-E53=Htv9+A@mail.gmail.com>
From:   Mark Hounschell <markh@compro.net>
Organization: Compro Computer Svcs.
Message-ID: <38775ed8-4fc3-8adb-510c-fe11a377fe15@compro.net>
Date:   Mon, 1 Oct 2018 13:38:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CA+t4uCPFZSTjyN-Wd3ppOp-edAXfSSTTdT8uab+-E53=Htv9+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/18 12:49 PM, Lidza Louina wrote:
> On Mon, Oct 1, 2018 at 8:09 AM Mark Hounschell <markh@compro.net 
> <mailto:markh@compro.net>> wrote:
> 
>     On 9/28/18 3:59 PM, Lidza Louina wrote:
>      > I haven't done work on this driver in a long time. I looked up the
>      > devices, and they seem to already have an existing Linux driver:
>      >
>     https://www.digi.com/products/usb-and-serial-connectivity/serial-cards/digineo and
> 
>      > https://www.digi.com/support/productdetail?pid=1694
>      >
>      > I've contacted the company to see if the driver is still needed in
>      > staging. I'll send an update once they get back to me.
>      >
>      > Lidza
>      >
> 
>     Good luck with that. Digi obsoleted ALL their PCI serial cards several
>     months ago. They would not even respond to requests from me to include
>     their firmware for their PCI dgap cards into the kernel firmware
>     package. The card for the dgnc driver is a pci-e card that may still be
>     supported by them however. Also there does appear to be an already in
>     kernel driver for these "PCI-e" cards too. It actually works as I
>     have a
>     couple of these cards. The module name is "jsm".
> 
> 
>     03:00.0 Serial controller: Digi International Device 00f0 (rev 02)
>     (prog-if 02 [16550])
>               Subsystem: Digi International Device 00f0
>               Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
>     ParErr- Stepping- SERR- FastB2B- DisINTx-
>               Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast
>      >TAbort-
>     <TAbort- <MAbort- >SERR- <PERR- INTx-
>               Interrupt: pin A routed to IRQ 29
>               Region 0: Memory at f7200000 (32-bit, non-prefetchable)
>     [size=4K]
>               Capabilities: [40] Power Management version 2
>                       Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA
>     PME(D0-,D1-,D2-,D3hot+,D3cold-)
>                       Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>               Kernel driver in use: jsm
>               Kernel modules: jsm
> 
> 
>     Regards
>     Mark
> 
> 
> Thanks for the heads up Mark. I've totally neglected this driver and 
> should have caught this earlier. I'm okay with removing it from staging. 
> We can bring it back if they need it.
> 

It may actually be my fault that Greg-KH added the dgnc driver to 
staging. Shortly after Digi stopped supporting their PCI cards, I had 
some contact with Greg-KH and sent him all the Digi GPL drivers that I 
was using at the time for possible inclusion. Digi was no longer 
maintaining them. I did not know at the time about the jsm driver 
already being there.

The dgnc driver supports the following PCI cards:
#define PCI_DEVICE_CLASSIC_4_DID                0x0028
#define PCI_DEVICE_CLASSIC_8_DID                0x0029
#define PCI_DEVICE_CLASSIC_4_422_DID            0x00D0
#define PCI_DEVICE_CLASSIC_8_422_DID            0x00D1

The jsm driver supports all of these plus their newer PCI-e cards:
#define PCI_DEVICE_ID_CLASSIC_4         0x0028
#define PCI_DEVICE_ID_CLASSIC_8         0x0029
#define PCI_DEVICE_ID_CLASSIC_4_422     0x00D0
#define PCI_DEVICE_ID_CLASSIC_8_422     0x00D1

#define PCI_DEVICE_ID_NEO_4             0x00B0
#define PCI_DEVICE_ID_NEO_1_422         0x00CC
#define PCI_DEVICE_ID_NEO_1_422_485     0x00CD
#define PCI_DEVICE_ID_NEO_2_422_485     0x00CE
#define PCIE_DEVICE_ID_NEO_8            0x00F0
#define PCIE_DEVICE_ID_NEO_4            0x00F1
#define PCIE_DEVICE_ID_NEO_4RJ45        0x00F2
#define PCIE_DEVICE_ID_NEO_8RJ45        0x00F3

So I think it is safe to remove the dgnc driver from staging. I also 
think the PCI-e versions defined above are actually still available from 
Digi as current products.

Regards
Mark

Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGuQKTGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 955F86086A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeFFGH2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:07:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37485 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeFFGH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:07:27 -0400
X-Google-Smtp-Source: ADUXVKJiALejZ7nasiBXarzb4bZ4tyxtmxGtd62BszmVUyZkmGHHpZbHoyDQ5kKGWy1CcRveE3WhngH+TqKDyLMuIcw=
MIME-Version: 1.0
In-Reply-To: <20180526193523.3896-1-mattst88@gmail.com>
References: <20180526193523.3896-1-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 5 Jun 2018 23:07:05 -0700
Message-ID: <CAEdQ38GR7XzjfjARuYxnr0dYGnCr_Sxn9bwwZJGZu7CJf6syvw@mail.gmail.com>
Subject: Re: [PATCH] parport: Add support for the WCH384 4S multi-IO card
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Sergej Pupykin <ml@sergej.pp.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 12:35 PM, Matt Turner <mattst88@gmail.com> wrote:
> This Multi-IO card has one serial 16550-like serial connectors. Here's
> the lspci output, after this commit is applied:
>
> 01:00.0 Serial controller [0700]: Device [1c00:3470] (rev 10) (prog-if 05 [16850])
>         Subsystem: Device [1c00:3470]
>         Flags: fast devsel, IRQ 16
>         I/O ports at e000 [size=256]
>         Memory at f0100000 (32-bit, prefetchable) [size=32K]
>         I/O ports at e100 [size=4]
>         Expansion ROM at f7d00000 [disabled] [size=32K]
>         Capabilities: [60] Power Management version 3
>         Capabilities: [68] MSI: Enable- Count=1/32 Maskable+ 64bit+
>         Capabilities: [80] Express Legacy Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Kernel driver in use: parport_serial
>
> This card was already added to the blacklist of 8250_pci.c in commit
> 72a3c0e4e662 ("tty: Add support for the WCH384 4S multi-IO card").
>
> Cc: Sergej Pupykin <ml@sergej.pp.ru>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---

Hi,

Can I expect this to be picked up for the 4.18 merge window?

Matt

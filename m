Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeA3Cwx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 21:52:53 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:32886 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbeA3Cwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 21:52:51 -0500
Date: Tue, 30 Jan 2018 13:52:38 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k/mac: Enable PDMA support for PowerBook 190
In-Reply-To: <CAMuHMdUiiPNV=CcxMJ3ZDjF0EV=voh_azEozWiGXni-CUbwEwg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1801301316110.3@nippy.intranet>
References: <20180127235140.D559728CE0@kvm5.telegraphics.com.au> <CAMuHMdUiiPNV=CcxMJ3ZDjF0EV=voh_azEozWiGXni-CUbwEwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018, Geert Uytterhoeven wrote:

> 
> Anyone with a PB520 who can check if it works now with scsi_type = 
> MAC_SCSI_OLD?
> 

The PB520 and PB540 have a flawed early-revision 68LC040 processor* which 
makes it unlikely that these machines are running Linux (or NetBSD). A few 
have had backyard CPU upgrades, like my own. I'll test MAC_SCSI_OLD at 
some point, but I don't know when that will be.

The PB550 doesn't have the 68LC040 problem but it was only available in 
Japan. These machines may have Linux or NetBSD on them, but they are rare 
and their owners may not be found on these lists.

* http://mac.linux-m68k.org/docs/faq.php#sec-4.5

-- 

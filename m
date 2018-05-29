Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967760AbeE2WQd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:16:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:45202 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967502AbeE2WQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:16:30 -0400
Message-ID: <3731dd7511b6a0ee74b062caf616e8041382fb90.camel@kernel.crashing.org>
Subject: Re: linux-next: Tree for May 29 (usb/gadget/udc/aspeed-vhub)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date: Wed, 30 May 2018 08:16:04 +1000
In-Reply-To: <00c69bdc-0b70-cb82-ee1e-2718acc19582@infradead.org>
References: <20180529204410.63477f88@canb.auug.org.au>
         <00c69bdc-0b70-cb82-ee1e-2718acc19582@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-29 at 10:04 -0700, Randy Dunlap wrote:
> On 05/29/2018 03:44 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20180525:
> > 
> 
> on i386:
> 
> when builtin:
> drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
> hub.c:(.text+0x3aa): undefined reference to `usb_gadget_get_string'
> 
> or when modular:
> ERROR: "usb_gadget_get_string" [drivers/usb/gadget/udc/aspeed-vhub/aspeed-vhub.ko] undefined!
> 
> 
> Full randconfig for modular build is attached.

Somebody already sent a fix for this. Thanks. (Missing a dependency on
LIBCOMPOSITE).

Cheers,
Ben.

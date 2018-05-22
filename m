Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeEVAfh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:35:37 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:32795 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbeEVAfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:35:34 -0400
X-Google-Smtp-Source: AB8JxZpFkqC7bsg9SQ+FWTp3/pOBKSB4nmlEKOQoIixZEX1+gEM4ysNkXcXAbeG7uuZ53oGZ5mNrGQ==
Date: Mon, 21 May 2018 20:35:31 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, trivial@kernel.org,
        linux-renesas-soc@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] NTB: ntb_hw_idt: fix typo 'can by' to 'can be'
Message-ID: <20180522003531.GB3255@kudzu.us>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
 <20180506112404.24872-7-wsa+renesas@sang-engineering.com>
 <20180511131236.GA24717@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511131236.GA24717@mobilestation>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 04:12:36PM +0300, Serge Semin wrote:
> On Sun, May 06, 2018 at 01:23:50PM +0200, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > index 8d98872d0983b7..dbe72f116017ab 100644
> > --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> > +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > @@ -1401,7 +1401,7 @@ static int idt_ntb_peer_mw_clear_trans(struct ntb_dev *ntb, int pidx,
> >   *                          5. Doorbell operations
> >   *
> >   *    Doorbell functionality of IDT PCIe-switches is pretty unusual. First of
> > - * all there is global doorbell register which state can by changed by any
> > + * all there is global doorbell register which state can be changed by any
> >   * NT-function of the IDT device in accordance with global permissions. These
> >   * permissions configs are not supported by NTB API, so it must be done by
> >   * either BIOS or EEPROM settings. In the same way the state of the global
> 
> Acked-by: Serge Semin <fancer.lancer@gmail.com>

Applied to my ntb-next branch.

Thanks,
Jon


> 
> > -- 
> > 2.11.0
> > 

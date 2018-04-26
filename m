Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756991AbeDZUFT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:05:19 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39114 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755248AbeDZUFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:05:15 -0400
X-Google-Smtp-Source: AIpwx49MQDyBaBTZP1f9M4n0uegXZyBWB2h7Yz2ZsLHanabHTX73bB8ATnoVJM9IOJd6omdrKzYGxA==
Date: Thu, 26 Apr 2018 22:05:11 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
        Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org,
        Antonio Quartulli <a@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix batadv_interface_tx()'s
 return type
Message-ID: <20180426200511.j45uth6y5y6ncsj6@ltop.local>
References: <20180424131847.5469-1-luc.vanoostenryck@gmail.com>
 <2141097.l2ETxyu3Mo@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2141097.l2ETxyu3Mo@sven-edge>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 07:35:00PM +0200, Sven Eckelmann wrote:
> On Dienstag, 24. April 2018 15:18:46 CEST Luc Van Oostenryck wrote:
> > The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> > which is a typedef for an enum type, but the implementation in this
> > driver returns an 'int'.
> > 
> > Fix this by returning 'netdev_tx_t' in this driver too.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  net/batman-adv/soft-interface.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied as 6bf9e4d39a58 [1] but the alignment was fixed

Thanks for this,
-- Luc 

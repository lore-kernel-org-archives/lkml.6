Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752930AbeDLRfq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:35:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38591 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbeDLRfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:35:44 -0400
X-Google-Smtp-Source: AIpwx491ZX3iWcjEve4TTwWYTkOkK/Km9/JmIEAja0d6YONZ1hz+mnstJnGemHdaIJwaXaJJnIJR4Q==
Date: Thu, 12 Apr 2018 10:35:40 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix receive time stamp race
 condition.
Message-ID: <20180412173540.rrjx5n62guchety2@localhost>
References: <20180409070314.12409-1-richardcochran@gmail.com>
 <20180409141931.kmltk4hridkj5fsk@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409141931.kmltk4hridkj5fsk@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 07:19:31AM -0700, Richard Cochran wrote:
> Dave, please hold off on this patch.  I am seeing new problems in my
> testing with this applied.  I still need to get to the bottom of
> this.

Looks like the new problems are a HW/board glitch.

The patch is good to go.
 
Thanks,
Richard

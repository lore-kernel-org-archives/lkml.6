Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeDIOTh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:19:37 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44242 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDIOTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:19:35 -0400
X-Google-Smtp-Source: AIpwx487mLIZfANYVPokDrSslUdxB3sKBVtCNWFCp6ai43jx30p9xj0Vdc+IAJ1EIiceJxejzvouuQ==
Date: Mon, 9 Apr 2018 07:19:31 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix receive time stamp race
 condition.
Message-ID: <20180409141931.kmltk4hridkj5fsk@localhost>
References: <20180409070314.12409-1-richardcochran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409070314.12409-1-richardcochran@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 12:03:14AM -0700, Richard Cochran wrote:
> This patch fixes the race by moving the queue onto a list on the stack
> before reading out the latched time stamp value.
> 
> Fixes: c6fe0ad2c3499 ("net: dsa: mv88e6xxx: add rx/tx timestamping support")

Dave, please hold off on this patch.  I am seeing new problems in my
testing with this applied.  I still need to get to the bottom of
this.

Thanks,
Richard

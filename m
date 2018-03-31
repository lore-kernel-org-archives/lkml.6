Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbeCaGRU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 02:17:20 -0400
Received: from mx3.wp.pl ([212.77.101.9]:17891 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752879AbeCaGRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 02:17:15 -0400
Date: Fri, 30 Mar 2018 23:17:05 -0700
From: Jakub Kicinski <kubakici@wp.pl>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mt7601u: phy: mark expected switch fall-through
Message-ID: <20180330231705.3d12f2a5@cakuba.netronome.com>
In-Reply-To: <20180330211223.GA22497@embeddedgus>
References: <20180330211223.GA22497@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: d3849007efbfef7bc8bbb8364fe54762
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [MYMk]                               
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018 16:12:23 -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Jakub Kicinski <kubakici@wp.pl>

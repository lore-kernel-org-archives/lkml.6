Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeFEOPj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:15:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36540 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbeFEOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:15:36 -0400
Date: Tue, 05 Jun 2018 10:15:32 -0400 (EDT)
Message-Id: <20180605.101532.899235999013307302.davem@davemloft.net>
To: andrew@lunn.ch
Cc: kai.heng.feng@canonical.com, hayeswang@realtek.com,
        hkallweit1@gmail.com, romieu@fr.zoreil.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryankao@realtek.com
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180605141114.GC14873@lunn.ch>
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
        <20180605141114.GC14873@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 5 Jun 2018 16:11:14 +0200

> No module parameter please. Just turn it on by default. Assuming
> testing shows works.

Agreed.

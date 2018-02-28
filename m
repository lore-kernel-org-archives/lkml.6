Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbeB1QkA convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:40:00 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:48840 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932968AbeB1Qj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:39:56 -0500
Date: Wed, 28 Feb 2018 11:39:54 -0500 (EST)
Message-Id: <20180228.113954.1697990302115142087.davem@davemloft.net>
To: hernan@vanguardiasur.com.ar
Cc: sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] emulex/benet: Constify *be_misconfig_evt_port_state[]
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519770563-20603-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1519770563-20603-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
Date: Tue, 27 Feb 2018 19:29:23 -0300

> Note: This is compile only tested as I have no access to the hw.
> No benefit gained except for some self-documenting.
> 
> add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> Function                                     old     new   delta
> Total: Before=2757703, After=2757703, chg +0.00%
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>

Applied to net-next.

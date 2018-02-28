Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934102AbeB1QkF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:40:05 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:48848 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932968AbeB1QkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:40:02 -0500
Date: Wed, 28 Feb 2018 11:40:01 -0500 (EST)
Message-Id: <20180228.114001.1671475208967462803.davem@davemloft.net>
To: hernan@vanguardiasur.com.ar
Cc: Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qlogic/qed: Constify *pkt_type_str[]
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519770694-20678-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1519770694-20678-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
Date: Tue, 27 Feb 2018 19:31:34 -0300

> Note: This is compile only tested as I have no access to the hw.
> Constifying and declaring as static saves 24 bytes.
> 
> add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-24 (-24)
> Function                                     old     new   delta
> pkt_type_str                                  24       -     -24
> Total: Before=3599256, After=3599232, chg -0.00%
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>

Applied to net-next.

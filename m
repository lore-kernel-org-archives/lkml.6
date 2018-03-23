Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeCWRUK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:20:10 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44240 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbeCWRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:20:08 -0400
Date: Fri, 23 Mar 2018 13:20:06 -0400 (EDT)
Message-Id: <20180323.132006.1430157484495473531.davem@davemloft.net>
To: dev@kresin.me
Cc: andrew@lunn.ch, f.fainelli@gmail.com, hauke@hauke-m.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: intel-xway: add VR9 version number
From: David Miller <davem@davemloft.net>
In-Reply-To: <1521757899-27813-1-git-send-email-dev@kresin.me>
References: <1521757899-27813-1-git-send-email-dev@kresin.me>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Kresin <dev@kresin.me>
Date: Thu, 22 Mar 2018 23:31:38 +0100

> The VR9 phy ids are matching only for the SoC version 1.2. Rename the
> macros and change the names to take this into account.
> 
> Signed-off-by: Mathias Kresin <dev@kresin.me>

Applied.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeC3Ok5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 10:40:57 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59734 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeC3Ok4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 10:40:56 -0400
Date: Fri, 30 Mar 2018 10:40:54 -0400 (EDT)
Message-Id: <20180330.104054.147506012234775496.davem@davemloft.net>
To: mike.looijmans@topic.nl
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        robh+dt@kernel.org, frowand.list@gmail.com
Subject: Re: [PATCH v4 0/2] of_net: Implement of_get_nvmem_mac_address
 helper
From: David Miller <davem@davemloft.net>
In-Reply-To: <1522301389-11034-1-git-send-email-mike.looijmans@topic.nl>
References: <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
        <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
        <1522301389-11034-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Looijmans <mike.looijmans@topic.nl>
Date: Thu, 29 Mar 2018 07:29:47 +0200

> Posted this as a small set now, with an (optional) second patch that shows
> how the changes work and what I've used to test the code on a Topic Miami board.
> I've taken the liberty to add appropriate "Acked" and "Review" tags.
> 
> v4: Replaced "6" with ETH_ALEN
> 
> v3: Add patch that implements mac in nvmem for the Cadence MACB controller
>     Remove the integrated of_get_mac_address call
> 
> v2: Use of_nvmem_cell_get to avoid needing the assiciated device
>     Use void* instead of char*
>     Add devicetree binding doc

Series applied to net-next, thank you.

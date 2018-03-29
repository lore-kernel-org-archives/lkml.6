Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeC2Pv4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 11:51:56 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44932 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeC2Pvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 11:51:37 -0400
Date: Thu, 29 Mar 2018 11:51:35 -0400 (EDT)
Message-Id: <20180329.115135.905687343263921395.davem@davemloft.net>
To: mdf@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, robh+dt@kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com
Subject: Re: [PATCH v6 2/2] net: ethernet: nixge: Add support for National
 Instruments XGE netdev
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180327214315.3224-2-mdf@kernel.org>
References: <20180327214315.3224-1-mdf@kernel.org>
        <20180327214315.3224-2-mdf@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>
Date: Tue, 27 Mar 2018 14:43:15 -0700

> Add support for the National Instruments XGE 1/10G network device.
> 
> It uses the EEPROM on the board via NVMEM.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Applied.

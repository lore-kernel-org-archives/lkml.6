Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754897AbeBATzC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:55:02 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:50020 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754870AbeBATyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:54:52 -0500
Date: Thu, 01 Feb 2018 14:54:50 -0500 (EST)
Message-Id: <20180201.145450.930634145855259446.davem@davemloft.net>
To: colin.king@canonical.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lan78xx: remove redundant initialization of pointer
 'phydev'
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180201171018.22267-1-colin.king@canonical.com>
References: <20180201171018.22267-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu,  1 Feb 2018 17:10:18 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer phydev is initialized and this value is never read, phydev
> is immediately updated to a new value, hence this initialization
> is redundant and can be removed
> 
> Cleans up clang warning:
> drivers/net/usb/lan78xx.c:2009:21: warning: Value stored to 'phydev'
> during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.

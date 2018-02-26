Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeBZTqV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:46:21 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:46234 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeBZTqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:46:20 -0500
Date: Mon, 26 Feb 2018 14:46:18 -0500 (EST)
Message-Id: <20180226.144618.918714632713424711.davem@davemloft.net>
To: fthain@telegraphics.com.au
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] Fixes, cleanup and modernization for SONIC
 ethernet drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1519514463.git.fthain@telegraphics.com.au>
References: <cover.1519514463.git.fthain@telegraphics.com.au>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Sat, 24 Feb 2018 18:27:24 -0500 (EST)

> Changes since v4 of combined patch series:
> - Removed redundant and non-portable MACH_IS_MAC tests.
> - Omitted patches unrelated to SONIC drivers.
> - Dropped changes to the 'version_printed' logic and debug message text.

Series applied, thank you.

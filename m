Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754192AbeCRPyq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:54:46 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCRPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:54:43 -0400
Date: Sun, 18 Mar 2018 11:54:38 -0400 (EDT)
Message-Id: <20180318.115438.1484174295219956260.davem@davemloft.net>
To: linux@roeck-us.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] sparc64: Oracle DAX driver depends on SPARC64
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519687278-9785-1-git-send-email-linux@roeck-us.net>
References: <1519687278-9785-1-git-send-email-linux@roeck-us.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 26 Feb 2018 15:21:18 -0800

> sparc:allmodconfig fails to build as follows.
> 
> ERROR: "mdesc_release" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "sun4v_hvapi_register" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "mdesc_get_property" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "mdesc_node_by_name" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "mdesc_grab" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "sun4v_ccb_info" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "sun4v_ccb_submit" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "sun4v_ccb_kill" [drivers/sbus/char/oradax.ko] undefined!
> 
> The symbols are only available with SPARC64 builds, thus the driver
> depends on it.
> 
> Fixes: dd0273284c74 ("sparc64: Oracle DAX driver")
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thank you.

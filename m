Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932297AbeENNfM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:35:12 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35294 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbeENNfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:35:08 -0400
Date: Mon, 14 May 2018 09:35:04 -0400 (EDT)
Message-Id: <20180514.093504.1396660355199793729.davem@davemloft.net>
To: acelan.kao@canonical.com
Cc: jcliburn@gmail.com, chris.snook@gmail.com, rakesh@tuxera.com,
        netdev@vger.kernel.org, emily.chien@canonical.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Revert "alx: remove WoL support"
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180514032839.32079-1-acelan.kao@canonical.com>
References: <20180514032839.32079-1-acelan.kao@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 14 May 2018 11:28:39 +0800

> This reverts commit bc2bebe8de8ed4ba6482c9cc370b0dd72ffe8cd2.
> 
> The WoL feature is a must to pass Energy Star 6.1 and above,
> the power consumption will be measured during S3 with WoL is enabled.
> 
> Reverting "alx: remove WoL support", and will try to fix the unintentional
> wake up issue when WoL is enabled.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=61651
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>

First, we must fix the problem that caused WoL to be disabled.

Then, and only then, can you re-enable it.

Thank you.

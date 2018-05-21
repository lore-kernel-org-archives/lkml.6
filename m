Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeEUDSZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 23:18:25 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48872 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbeEUDSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 23:18:23 -0400
Date: Sun, 20 May 2018 23:18:20 -0400 (EDT)
Message-Id: <20180520.231820.868530785962553925.davem@davemloft.net>
To: acelan.kao@canonical.com
Cc: jcliburn@gmail.com, chris.snook@gmail.com, rakesh@tuxera.com,
        netdev@vger.kernel.org, emily.chien@canonical.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Revert "alx: remove WoL support"
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAFv23Q=RGo5Tw4sL5GiYM69xeGUPReiBE290rnzCvOPezQinCg@mail.gmail.com>
References: <20180514032839.32079-1-acelan.kao@canonical.com>
        <20180514.093504.1396660355199793729.davem@davemloft.net>
        <CAFv23Q=RGo5Tw4sL5GiYM69xeGUPReiBE290rnzCvOPezQinCg@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 21 May 2018 11:14:00 +0800

> We are willing to fix the issue, but we don't have a machine to
> reproduce it, and the WoL feature has been removed 5 years ago, it's
> hard to find those buggy machines.

Have you bothered to ask the person who did the revert?

> WoL is a feature that is only used by a very small group of people,
> and the wake up issue looks like only happens on some
> platforms. Which means only small part of the group of people are
> affected.

One of those people was the wireless networking stack maintainer.

> So, it's not a serious issue worth to remove it from alx driver.

I disagree.

You must fix the regression solved by the revert, before adding
WoL support back to the driver.

I'm not going to say this again.

Thank you.

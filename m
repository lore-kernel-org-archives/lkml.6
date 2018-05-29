Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935506AbeE2O5S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:57:18 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56316 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934913AbeE2O5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:57:10 -0400
Date: Tue, 29 May 2018 10:57:08 -0400 (EDT)
Message-Id: <20180529.105708.501645682079905183.davem@davemloft.net>
To: acelan.kao@canonical.com
Cc: jcliburn@gmail.com, chris.snook@gmail.com, rakesh@tuxera.com,
        netdev@vger.kernel.org, emily.chien@canonical.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, johannes@sipsolutions.net, js@sig21.net
Subject: Re: [PATCH v2] Revert "alx: remove WoL support"
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAFv23QnGJz8YUwzqmzHii=Obg8D9sb25Z4A+FFv2ze7HYXXG8g@mail.gmail.com>
References: <CAFv23Q=RGo5Tw4sL5GiYM69xeGUPReiBE290rnzCvOPezQinCg@mail.gmail.com>
        <20180520.231820.868530785962553925.davem@davemloft.net>
        <CAFv23QnGJz8YUwzqmzHii=Obg8D9sb25Z4A+FFv2ze7HYXXG8g@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 28 May 2018 13:06:31 +0800

> Hi all,
> 
> Just inform you a news reported by a user who confirmed the wake up
> issue can't be reproduce by the new kernel.
> https://bugzilla.kernel.org/show_bug.cgi?id=61651#c126
> 
> <quote>
> Guillaume de Jabrun 2018-05-27 15:12:54 UTC
> 
> I am using this patch for a long time. I was experiencing the "wake up
> twice" bug, but with recent kernel version, I don't have this issue
> anymore.
> I can't tell which version actually fix the bug (I don't remember..).
> </quote>

Ok, please resubmit the revert and let's see what happens.

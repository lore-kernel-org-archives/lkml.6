Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA24C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3843521480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3843521480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392034AbeHPSeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbeHPSeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:34:36 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB90220C51;
        Thu, 16 Aug 2018 15:35:22 +0000 (UTC)
Date:   Thu, 16 Aug 2018 11:35:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tobias Waldekranz <tobias@waldekranz.com>
Cc:     <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] net: phy: add tracepoints
Message-ID: <20180816113521.55637a71@gandalf.local.home>
In-Reply-To: <20180816152452.7834-1-tobias@waldekranz.com>
References: <20180816152452.7834-1-tobias@waldekranz.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 17:24:48 +0200
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> Two tracepoints for now:
> 
>    * `phy_interrupt` Pretty self-explanatory.
> 
>    * `phy_state_change` Whenever the PHY's state machine is run, trace
>      the old and the new state.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> v1 -> v2:
>    * Actually include the entire patch, based on current net-next.
>    * Pretty print the PHY's state according to Steven's suggestion.

Cool!

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---

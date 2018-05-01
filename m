Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756456AbeEAS0V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:26:21 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48632 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756157AbeEAS0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:26:19 -0400
Date: Tue, 01 May 2018 14:26:18 -0400 (EDT)
Message-Id: <20180501.142618.2096083030186678136.davem@davemloft.net>
To: sstrogin@cisco.com
Cc: zbr@ioremap.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com, jderehag@hotmail.com,
        matt.helsley@gmail.com
Subject: Re: [PATCH RESEND] connector: add parent pid and tgid to coredump
 and exit events
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180430220429.14788-1-sstrogin@cisco.com>
References: <20180430220429.14788-1-sstrogin@cisco.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Strogin <sstrogin@cisco.com>
Date: Tue,  1 May 2018 01:04:29 +0300

> The intention is to get notified of process failures as soon
> as possible, before a possible core dumping (which could be very long)
> (e.g. in some process-manager). Coredump and exit process events
> are perfect for such use cases (see 2b5faa4c553f "connector: Added
> coredumping event to the process connector").
> 
> The problem is that for now the process-manager cannot know the parent
> of a dying process using connectors. This could be useful if the
> process-manager should monitor for failures only children of certain
> parents, so we could filter the coredump and exit events by parent
> process and/or thread ID.
> 
> Add parent pid and tgid to coredump and exit process connectors event
> data.
> 
> Signed-off-by: Stefan Strogin <sstrogin@cisco.com>
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

Applied to net-next, thank you.

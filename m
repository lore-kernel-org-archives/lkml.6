Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeBSP5r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:57:47 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:42555 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753143AbeBSP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:57:44 -0500
X-Google-Smtp-Source: AH8x225+HabFbSAXH2xEVNm5gFz9MEfkR0/LS0V5y/2SjF6YD78fo8kQoZX22qMvW9R8KxXAWu+HfWIFI74AIcEPCmo=
MIME-Version: 1.0
In-Reply-To: <1510586871-27478-1-git-send-email-brian.starkey@arm.com>
References: <1510586871-27478-1-git-send-email-brian.starkey@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 19 Feb 2018 15:57:42 +0000
X-Google-Sender-Auth: 3grX-P7ROmt1_1SRKkL3jLtiI04
Message-ID: <CAPKp9uZY_4Hm9oq_aBdWPAhvZv-LbxezWu3rU86kw9+kFAXJ6g@mail.gmail.com>
Subject: Re: [PATCH] clk: versatile: Remove WARNs in ->round_rate()
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: open list <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Brian Starkey <brian.starkey@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2017 at 3:27 PM, Brian Starkey <brian.starkey@arm.com> wrote:
> clk_round_rate() is intended to be used to round a given clock rate to
> the closest one achievable by the actual clock. This implies that the
> input to clk_round_rate() is expected to be unachievable - and such
> cases shouldn't be treated as exceptional.
>
> To reflect this, remove the WARN_ONs which trigger when an unachievable
> clock rate is passed to vexpress_osc_round_rate().
>
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Ping!

Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D269C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3614B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfBFK2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:28:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55731 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBFK2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:28:45 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 6dbad86b720669ba; Wed, 6 Feb 2019 11:28:42 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, biju.das@bp.renesas.com,
        linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org,
        thara.gopinath@linaro.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/2] PM-runtime: fix and clean up of time accounting
Date:   Wed, 06 Feb 2019 11:27:30 +0100
Message-ID: <30395680.vVXis5MGQY@aspire.rjw.lan>
In-Reply-To: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 4, 2019 5:25:51 PM CET Vincent Guittot wrote:
> Fix time accounting which has the same lock contraint as for using hrtimer
> and update accounting_timestamp only when useful.
> 
> Vincent Guittot (2):
>   PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
>   PM-runtime: update time accounting only when enabled
> 
>  drivers/base/power/runtime.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> 

Both applied, thanks!



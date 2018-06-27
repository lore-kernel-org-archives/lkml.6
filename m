Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A340C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A0A25B9D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A0A25B9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933674AbeF0IvA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:51:00 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:30280 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933470AbeF0Iuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:50:55 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d82 with ME
        id 3kqR1y00C41oiFu03kqV9M; Wed, 27 Jun 2018 10:50:53 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 27 Jun 2018 10:50:53 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: pxa: export 32kHz PLL
References: <20180626200308.16192-1-robert.jarzmik@free.fr>
        <201806270855.xvEN3vnK%fengguang.wu@intel.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 27 Jun 2018 10:50:23 +0200
In-Reply-To: <201806270855.xvEN3vnK%fengguang.wu@intel.com> (kbuild test
        robot's message of "Wed, 27 Jun 2018 08:16:16 +0800")
Message-ID: <87vaa4lik0.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:

> All errors (new ones prefixed by >>):
>
>    drivers/clk/pxa/clk-pxa25x.c: In function 'pxa25x_register_plls':
>>> drivers/clk/pxa/clk-pxa25x.c:298:17: error: expected ')' before ';' token
>               32768);
>                     ^
>>> drivers/clk/pxa/clk-pxa25x.c:304:1: error: expected ';' before '}' token
>     }
Meh a missing closing parenthesis ... I'll send a v3.

Cheers.

--
Robert

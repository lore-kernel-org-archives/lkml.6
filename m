Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3623DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B862133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeLQKRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:17:16 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52659 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbeLQKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:17:15 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d8c065c3e97b84ac; Mon, 17 Dec 2018 11:17:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v13 0/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
Date:   Mon, 17 Dec 2018 11:16:50 +0100
Message-ID: <36800685.BEkRLjAyIo@aspire.rjw.lan>
In-Reply-To: <20181214044213.kae2yhogbrgomyu6@vireshk-i7>
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org> <20181214044213.kae2yhogbrgomyu6@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, December 14, 2018 5:42:13 AM CET Viresh Kumar wrote:
> On 14-12-18, 09:40, Taniya Das wrote:
> >  [v13]
> >    * Update Documentation binding to #freq-domain-cells in description.
> >    * Replace devm_ioremap_resource() to use devm_ioremap() API.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

The series has been applied, thanks!


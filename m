Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4C092C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B876208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B876208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934290AbeFLO6s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:58:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58431 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933571AbeFLO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:58:46 -0400
Received: from 79.184.255.56.ipv4.supernova.orange.pl (79.184.255.56) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id dd896c84f7d3978d; Tue, 12 Jun 2018 16:58:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Shawn Guo <shawnguo@kernel.org>,
        =?ISO-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
Date:   Tue, 12 Jun 2018 16:57:43 +0200
Message-ID: <1843576.EaGtSTJKjV@aspire.rjw.lan>
In-Reply-To: <20180611053826.GC16091@dragon>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com> <20180611053826.GC16091@dragon>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 11, 2018 7:38:27 AM CEST Shawn Guo wrote:
> On Tue, May 22, 2018 at 08:28:51AM +0200, Sébastien Szymanski wrote:
> > Check the max speed supported from the fuses for i.MX6ULL and update the
> > operating points table accordingly.
> > 
> > Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>

Patch applied, thanks!


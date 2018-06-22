Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD30CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664E823DE1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664E823DE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeFVGlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:41:53 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:56256 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeFVGlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:41:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id B28CC1254;
        Fri, 22 Jun 2018 08:41:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SSSkKlI8aGz8; Fri, 22 Jun 2018 08:41:49 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (static-176-158-111-12.ftth.abo.bbox.fr [176.158.111.12])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 0BFDA1245;
        Fri, 22 Jun 2018 08:41:49 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fWFlS-0000hR-RZ; Fri, 22 Jun 2018 08:41:46 +0200
Date:   Fri, 22 Jun 2018 08:41:46 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Dave Mielke <Dave@mielke.cc>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
Message-ID: <20180622064146.7x6dh7hruidjgtag@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Adam Borowski <kilobyte@angband.pl>, Dave Mielke <Dave@mielke.cc>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
 <20180619130953.bxil552igfkckjmr@angband.pl>
 <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr>
 <20180621014317.ebslk3gwvpq3k6sq@angband.pl>
 <20180621022137.GB18453@beta.private.mielke.cc>
 <20180622015445.7r5u5nn6ofhd4k57@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622015445.7r5u5nn6ofhd4k57@angband.pl>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Borowski, le ven. 22 juin 2018 03:54:45 +0200, a ecrit:
> if the former, this is my way to show you how actual Latin letters
> look like, without a lengthy description of letter shapes. :) )

What will unfortunately not work: braille displays only show one line at
a time, so they can't show the global shape of a figure, unless it is
only 4pixels tall.

Samuel

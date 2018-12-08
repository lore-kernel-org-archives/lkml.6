Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF75C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F242083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F242083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeLHFOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 00:14:16 -0500
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:60046 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbeLHFOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 00:14:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B03C6837F243;
        Sat,  8 Dec 2018 05:14:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cry77_7cf6ab5cca3d
X-Filterd-Recvd-Size: 1253
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat,  8 Dec 2018 05:14:13 +0000 (UTC)
Message-ID: <1bb3bde9a47a3ca8a026fab9e6af420c1ae59f97.camel@perches.com>
Subject: Re: [PATCH V3 1/4] spi: lpspi: Replace all "master" with
 "controller"
From:   Joe Perches <joe@perches.com>
To:     Clark Wang <xiaoning.wang@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Dec 2018 21:14:12 -0800
In-Reply-To: <20181207024924.6315-2-xiaoning.wang@nxp.com>
References: <20181207024924.6315-1-xiaoning.wang@nxp.com>
         <20181207024924.6315-2-xiaoning.wang@nxp.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 02:50 +0000, Clark Wang wrote:
> In order to enable the slave mode and make the code more readable,
> replace all related structure names and object names which is
> named "master" with "controller".

In what sense does this make the code more readable?



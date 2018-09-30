Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29076C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B007B206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B007B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeJADEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 23:04:40 -0400
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:51616 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728505AbeJADEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 23:04:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E730D180A8428;
        Sun, 30 Sep 2018 20:30:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cub14_3c166de5ae259
X-Filterd-Recvd-Size: 1357
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Sep 2018 20:30:12 +0000 (UTC)
Message-ID: <c9e0b48d829e9b598b7bb68d1152e56ef0c846f9.camel@perches.com>
Subject: Re: [PATCH 01/19] staging: rtl8188eu: cleanup inconsistent indenting
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 30 Sep 2018 13:30:11 -0700
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-30 at 21:52 +0200, Michael Straube wrote:
> Cleanup all inconsistent indenting reported by smatch.

There are also some others like:

drivers/staging/rtl8188eu/core/rtw_mlme.c:1752: WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 24)
1750:	if ((ndisauthmode == Ndis802_11AuthModeWPA) ||
1751:	    (ndisauthmode == Ndis802_11AuthModeWPAPSK))
1752:			authmode = _WPA_IE_ID_;

Perhaps smatch can be enhanced to find those too.



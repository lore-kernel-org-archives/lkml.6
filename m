Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83289C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B76205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B76205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeIEWMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:12:50 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:51334 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIEWMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:12:50 -0400
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 071DA3A0C0A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Sep 2018 19:12:28 +0200 (CEST)
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 555CA2000A;
        Wed,  5 Sep 2018 17:12:24 +0000 (UTC)
Date:   Wed, 5 Sep 2018 19:20:23 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Elie Roudninski <xademax@gmail.com>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [RFC PATCH 0/4] Add specific vt input's key map
Message-ID: <20180905172022.GA30233@voidbox.localdomain>
References: <cover.1534972811.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1534972811.git.repk@triplefau.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a gentle ping.

Any comments on this patchset that adds a way to have multiple
keyboards with different keymap on a VT would be nice.

Thanks

-- 
Remi

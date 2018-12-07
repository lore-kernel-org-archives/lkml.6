Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92049C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB7220837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB7220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLGRWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:22:08 -0500
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:57852 "EHLO
        4.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeLGRWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:22:07 -0500
X-Greylist: delayed 19200 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2018 12:22:06 EST
Received: from player728.ha.ovh.net (unknown [10.109.159.248])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 06834209BEC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Dec 2018 12:24:32 +0100 (CET)
Received: from RCM-web6.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 84E8D8707D2;
        Fri,  7 Dec 2018 11:24:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 07 Dec 2018 12:24:28 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: gpio: Drop unneeded manual of_node assignment
In-Reply-To: <1544177406-24752-1-git-send-email-krzk@kernel.org>
References: <1544177406-24752-1-git-send-email-krzk@kernel.org>
Message-ID: <8a33e544f7f5c4ec24556484c8694379@milecki.pl>
X-Sender: rafal@milecki.pl
User-Agent: Roundcube Webmail/1.3.8
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
X-Ovh-Tracer-Id: 6372593474920025753
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudefledgvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-07 11:10, Krzysztof Kozlowski wrote:
> This reverts the main change of commit bff23714bc36 ("leds: leds-gpio:
> Set of_node for created LED devices") because of_node assignment is
> handled by core since commit 7ea79ae86c28 ("leds: gpio: use OF variant
> of LED registering function").  Basically the code was overwriting the
> of_node with same value.
> 
> No functional change expected.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks!

Tested-by: Rafał Miłecki <rafal@milecki.pl>

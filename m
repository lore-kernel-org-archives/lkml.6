Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152F4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C972B20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C972B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeGYJl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:41:26 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:32095 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeGYJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:41:25 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiuc1qET/2Lw=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6P8UhdfP
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 10:30:43 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] drivers: net: wlcore: remove duplicate \n for some warnings
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <87lg9zyg1p.fsf@codeaurora.org>
Date:   Wed, 25 Jul 2018 10:30:45 +0200
Cc:     Arnd Bergmann <arnd@arndb.de>, "Reizer, Eyal" <eyalr@ti.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Content-Transfer-Encoding: 7bit
Message-Id: <F5C1808B-516D-4D74-BC43-6E997D9F012A@goldelico.com>
References: <af660348ade58fd33396d2dca432536d2ac85cf7.1532498079.git.hns@goldelico.com> <87lg9zyg1p.fsf@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 25.07.2018 um 08:40 schrieb Kalle Valo <kvalo@codeaurora.org>:
> 
> "H. Nikolaus Schaller" <hns@goldelico.com> writes:
> 
>> wl1271_warning() already appends a \n to the format,
>> so adding one to the warning string gives empty lines in the log.
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> 
> "drivers: net:" in the title is unnecessary, but I can remove that.

Ok, thanks! I wasn't aware of the precise subsystem tagging style here.

BR,
Nikolaus


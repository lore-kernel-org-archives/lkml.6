Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57704ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17C72124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 04:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17C72124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amitshah.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeGMFBh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:01:37 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33553 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeGMFBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:01:37 -0400
X-Originating-IP: 185.220.70.142
Received: from [10.21.10.6] (unknown [185.220.70.142])
        (Authenticated sender: amit@amitshah.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C1FB4E0002;
        Fri, 13 Jul 2018 04:48:43 +0000 (UTC)
Date:   Fri, 13 Jul 2018 06:48:45 +0200
In-Reply-To: <20180712213956.21516-1-tuomas@tuxera.com>
References: <20180712213956.21516-1-tuomas@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 1/3] virtio: virtconsole: Use seq_file for debugfs operations
To:     Tuomas Tynkkynen <tuomas@tuxera.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
CC:     Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
From:   Amit Shah <amit@amitshah.net>
Message-ID: <240C205A-1C62-4234-A4C4-116C185DEF5B@amitshah.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 12. Juli 2018 23:39:56 MESZ schrieb Tuomas Tynkkynen <tuomas@tuxera.com>:
>Simplifies the code and is more conventional to what's used in the rest
>of the kernel for debugfs ops.
>
>Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Looks good, thanks.

Reviewed-by: Amit Shah <amit@kernel.org>


                Amit

-- 
http://amitshah.net

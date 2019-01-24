Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96875C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6714F21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfAXXNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:13:41 -0500
Received: from sdaoden.eu ([217.144.132.164]:58858 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfAXXNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:13:41 -0500
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 09CE61604A; Fri, 25 Jan 2019 00:13:39 +0100 (CET)
Date:   Fri, 25 Jan 2019 00:14:10 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: 4.19.{12,[13],14}: RIP:
 0010:nf_conncount_cache_free+0x26/0x2f [nf_conncount]
Message-ID: <20190124231410.YGNS4%steffen@sdaoden.eu>
In-Reply-To: <20190118131055.RtuE5%steffen@sdaoden.eu>
References: <20190112000517.nQ-CW%steffen@sdaoden.eu>
 <20190118131055.RtuE5%steffen@sdaoden.eu>
User-Agent: s-nail v14.9.11-153-g6e7613f7
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and good evening,

Steffen Nurpmeso wrote in <20190118131055.RtuE5%steffen@sdaoden.eu>:
  ...
 |The problem still persists with v14.19.15, i have reverter to
 ...
 |Jan 18 12:40:00 kernel: [37953.963613] BUG: unable to handle kernel \
 |NULL pointer dereference at 0000000000000000
 ...
 |  Jan 18 00:40:00 kernel: [38154.458219] RIP: 0010:nf_conncount_cache_free\
 |  +0x26/0x2f [nf_conncount]
 ...

No problems now with v4.19.17, thank you very much!
I guess this makes an australian eight cylindre, or a 1000 KW
electric car.  Rammed straight in space here on my side, anyway.

Ciao, and keep on rocking!!!

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)

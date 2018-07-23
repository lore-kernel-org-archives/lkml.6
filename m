Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C44ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865A220858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="YzsyzLhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865A220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbeGWGIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:08:21 -0400
Received: from mout01.posteo.de ([185.67.36.65]:60357 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387772AbeGWGIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:08:21 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0903921126
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1532322538; bh=32qG+e0Ctg/p2hCyIDfzIgdNWfBMTQ8gdLzU2ww3Cio=;
        h=Subject:To:Cc:From:Date:From;
        b=YzsyzLhnrv3hszK1LijdAnPzEdzxehCQTdDHvNRwPrgrfdMNvgJEOjgQWSvCPmpQU
         iBGMTGmGKMFYZVPks7ojBnsj/f/lDkQE8xAOsOnm/phPlE9e587SnZxVRYKUyXONSQ
         rBRjwyuV62UgEE6YmtemoY5aFuweNVYcw57Ukhz5985/RmFy7jxoGjVth8tAuATydH
         FRttjKStOOiawyNq9BD2lAyHwJN3du5ar8ADBuvVQtRv5ABqRVMBiYDDf5mxlzQY0F
         xoH2EPxiutGOB94sC1+t7J/GfjuMjWbeRWc5TxYemKJJutIZJu08QjcCNWSbWrMhwm
         jmY37UjAdZpxQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41YqK41m3gz6tm9;
        Mon, 23 Jul 2018 07:08:55 +0200 (CEST)
Subject: Re: [PATCH 11/11] touchscreen: tsc200x: Use octal permissions
To:     dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
 <20180721191029.25658-10-harshitjain6751@gmail.com>
From:   Martin Kepplinger <martink@posteo.de>
Message-ID: <93e4394e-5f2c-6134-1046-8177cbeaee4c@posteo.de>
Date:   Mon, 23 Jul 2018 07:08:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180721191029.25658-10-harshitjain6751@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-21 21:09, dev-harsh1998 wrote:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider usi=
ng octal permissions '0444'.
> +static DEVICE_ATTR(selftest, S_IRUGO, tsc200x_selftest_show, NULL);
>=20
> Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>

Acked-by: Martin Kepplinger <martink@posteo.de>


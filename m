Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0B6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A70720863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FiwcKfRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfBHQ4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:56:06 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47461 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfBHQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:56:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190208165604euoutp02ab84aad29191ac82d83d725ba71322d3~BceKATbEY0644406444euoutp02M
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 16:56:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190208165604euoutp02ab84aad29191ac82d83d725ba71322d3~BceKATbEY0644406444euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549644964;
        bh=Zyj8+ElW1IhCod2wLVfAmJ9E8Asr0PGDTz9XR+Fth5Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FiwcKfRpJRxedGJUwe/TnmNFO1fNfRR6RqUz+rTClh67QQpRglLIlY/rSEp+Fl9XL
         5VnIjzJ+kXpYPrUNRxwkYB6GYhhqRYCHUz6sPqyU2FBdpKUpfIXia8+UyOUC1TTZUp
         Yhd8H2IG0lSHhJ8chXtZtkp62Y6rvkvAVfAepCiw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190208165603eucas1p1b8175af47e68d9deeaa48f24f01b7eb9~BceI8Q80n2804328043eucas1p16;
        Fri,  8 Feb 2019 16:56:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D8.F6.04806.2A4BD5C5; Fri,  8
        Feb 2019 16:56:02 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190208165602eucas1p1759e9282b387575bfe5343eefba5b9ab~BceIFHvNe1330613306eucas1p1M;
        Fri,  8 Feb 2019 16:56:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190208165602eusmtrp19ee10f0925adf8a8ad6b438ba3e9a993~BceH257ZE3260632606eusmtrp1T;
        Fri,  8 Feb 2019 16:56:02 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-b1-5c5db4a264b2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EA.63.04284.2A4BD5C5; Fri,  8
        Feb 2019 16:56:02 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190208165601eusmtip10133feae194b250dc582eb057658557a~BceHh5JB40944709447eusmtip1V;
        Fri,  8 Feb 2019 16:56:01 +0000 (GMT)
Subject: Re: [PATCH] fbdev/via: fix spelling mistake "Expandsion" ->
 "Expansion"
To:     Colin King <colin.king@canonical.com>
Cc:     Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <003227d9-7b9f-6d9b-3a0d-acaa833ee179@samsung.com>
Date:   Fri, 8 Feb 2019 17:55:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181012224710.26867-1-colin.king@canonical.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzned1FW2JjDPqPW1v8Xt3LZnHl63s2
        i86Z1xgttt6StjjR94HV4vKuOWwObB6zGnrZPD58jPO4332cyePzJrkAligum5TUnMyy1CJ9
        uwSujJ7dF9gKHjNVrFrWzdrAuJipi5GTQ0LARGLP9HlsXYxcHEICKxglVjf3MUM4XxglTr56
        zQhSJSTwmVHi+QN3mI5D5++zQhQtZ5Q4O60TquM9o8SsV3+A5nJwCAsESXzaxAViighoSpw/
        VwRSwiywk1Fi7brbbCCD2ASsJCa2rwJbwCtgJ7H96xRWEJtFQEVix6w37CC9ogIREv1n1CFK
        BCVOznzCAhLmBCo/fdoMJMwsIC+x/e0cZojTJrNLTNvABmG7SHTdnwoVF5Z4dXwLO4QtI3F6
        cg8LyDkSAtMZJd78WgrlrGeUWHPmGDRYrCUOH7/ICrKMGej+9bv0IcKOEksaz4OdJiHAJ3Hj
        rSDEDXwSk7ZNZ4YI80p0tAlBVKtJbFgGc46MRNfOlVDneEgsmXKEdQKj4iwkj81C8s0shL0L
        GJlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBCaT0/+Of93BuO9P0iFGAQ5GJR7eiJbY
        GCHWxLLiytxDjBIczEoivGmbgEK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGan
        phakFsFkmTg4pRoYa4u3HciYo3/iRON235ffjpTaXn6nsW3XzboKkYAyU/PbBv6OtX9X5Mw+
        JCknd/wV56ezTY/5AgMyrFfM6VaUPLM4nD1CrjflgJZXdw0Tc3Bl5a/d1z9slH5rLRXs5Gw+
        M5//u/PJ2smfy++Xx/e0vpqvnhMS5TpT/O7ZvI+ntx12tNmt9dxTiaU4I9FQi7moOBEAss+9
        GCIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7qLtsTGGGxay2Lxe3Uvm8WVr+/Z
        LDpnXmO02HpL2uJE3wdWi8u75rA5sHnMauhl8/jwMc7jfvdxJo/Pm+QCWKL0bIryS0tSFTLy
        i0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mnp2X2AreMxUsWpZN2sD
        42KmLkZODgkBE4lD5++zdjFycQgJLGWUmLbvMZDDAZSQkTi+vgyiRljiz7UuNoiat4wSS95M
        YwKpERYIkvi0iQvEFBHQlDh/rgiiZCKjxM0fvSwgDrPATkaJ/RvusoEMYhOwkpjYvooRxOYV
        sJPY/nUKK4jNIqAisWPWG3YQW1QgQuLWww4WiBpBiZMzn7CALOAEqj992gwkzCygLvFn3iVm
        CFteYvvbOcwTGAVnIemYhaRsFpKyBYzMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIjZdux
        n5t3MF7aGHyIUYCDUYmHl6EpNkaINbGsuDL3EKMEB7OSCG/aJqAQb0piZVVqUX58UWlOavEh
        RlOgHyYyS4km5wOjOK8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dU
        A6Pu7IhNnI8LFJ95Oi2tcX2T8O/p72VLg/59uXZfJsdy0vJ+VfPNm3o1JrqzGt7vObNte/+5
        9eF7xKMn6y3xsD8086dfY/uSBUsd3h19/8PqtNO5+3Y+qbU5Tw9M9nV906eQtsbohoI1l+uU
        zCT9XUd1ZWyMtNq+uhmIOqkYnd1u6lO4xvJL524lluKMREMt5qLiRADY7iMKqgIAAA==
X-CMS-MailID: 20190208165602eucas1p1759e9282b387575bfe5343eefba5b9ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181012224715epcas2p199717104dd8ed929a91296bf9ee5f10b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181012224715epcas2p199717104dd8ed929a91296bf9ee5f10b
References: <CGME20181012224715epcas2p199717104dd8ed929a91296bf9ee5f10b@epcas2p1.samsung.com>
        <20181012224710.26867-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/2018 12:47 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in MODULE_PARM_DESC text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

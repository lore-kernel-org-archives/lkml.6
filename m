Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeEOKkQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:40:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44987 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeEOKkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:40:12 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180515104011euoutp016ecb3d6ab3edc344d175e890c77e3fc3~uy0KxJCJo1201412014euoutp01V
X-AuditID: cbfec7f5-b5fff700000028a9-ab-5afab90a3dfd
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Colin King <colin.king@canonical.com>
Cc: Markus Elfring <elfring@users.sourceforge.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: fix spelling mistake: "frambuffer" ->
 "framebuffer"
Date: Tue, 15 May 2018 12:40:08 +0200
Message-id: <2254363.7hXMTGaTqE@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180501083742.22565-1-colin.king@canonical.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djP87pcO39FGVz4z2Kx9eBcVovfq3vZ
        LK58fc9mcb5zObPF1lvSFif6PrBaXN41h82B3WNWQy+bx/3u40weTafaWT0+b5Lz+Hx3PWsA
        axSXTUpqTmZZapG+XQJXxoYz3gWvmSo+nn/E0sC4jKmLkYNDQsBE4sLmii5GLg4hgRWMEv+O
        HmLuYuQEcj4zSrx9Xw5Tc/BaMUR4GaPE5pkWEPW/GSVmLWpmAUmwCVhJTGxfxQhSLyKgKXH+
        XBFIDbPAS0aJNxdbwWYKC0RI/P27mgnEZhFQlbixeBELSD0vUP3k92BhUQEviS372sFsTgE7
        iV/vlrGB2LwCghI/Jt8DW8UsIC+xb/9UVghbR+LssXWMILskBLawSVw+/w3qLxeJVe/MQGok
        BIQlXh3fwg5hy0hcntzNAlHfzCjxbcceZojEBEaJPeuFIGxricPHL0It4JOYtG06M8RMXomO
        NqgSD4mNF85AzXSUmLryIxMkTCYySpzdeoV5AqPsLCR3z0Jy9ywkdy9gZF7FKJ5aWpybnlps
        nJdarlecmFtcmpeul5yfu4kRmBpO/zv+dQfjvj9JhxgFOBiVeHh3zPgZJcSaWFZcmXuIUYKD
        WUmEd7cRUIg3JbGyKrUoP76oNCe1+BCjNAeLkjhvnEZdlJBAemJJanZqakFqEUyWiYNTqoHR
        5tafgGevTnlw3Iu/fpXjWsy1Qx8LnZhT30R5dsrFLV+xQZAtwDFpWcy3qQs7331NbXNJe63h
        +eS6PiNn0s0s7YjfkZ+EbwSt/VR0/MEP9b2NZ4/V3uqsOx1Q/XJz6Prc7TI/LfVXrNgs0fPM
        eMv0ZW8/HNoQuf9SlEx5o5XwgdL7yxbIZj26o8RSnJFoqMVcVJwIAHRruKUJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t/xa7qcO39FGbTtkrTYenAuq8Xv1b1s
        Fle+vmezON+5nNli6y1pixN9H1gtLu+aw+bA7jGroZfN4373cSaPplPtrB6fN8l5fL67njWA
        NYrLJiU1J7MstUjfLoErY8MZ74LXTBUfzz9iaWBcxtTFyMEhIWAicfBacRcjF4eQwBJGiZcH
        ZjNDOH8ZJY6sm8jYxcjJwSZgJTGxfRUjSIOIgKbE+XNFIDXMAi8ZJfrm3QarERaIkPj7dzUT
        iM0ioCpxY/EiFpB6XqD6ye/BwqICXhJb9rWD2ZwCdhK/3i1jg9g1mVFi1dUbbCAJXgFBiR+T
        77GA2MwC8hL79k9lhbC1JNbvPM40gZF/FpKyWUjKZiEpW8DIvIpRJLW0ODc9t9hIrzgxt7g0
        L10vOT93EyMwjLcd+7llB2PXu+BDjAIcjEo8vDtm/IwSYk0sK67MPcQowcGsJMK72wgoxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6YklqdmpqQWoRTJaJg1OqgbFn2+HCPd8e/+/J
        /mBW9a5gSsLfnCefHc5P2Jyjrrl1RY5jKcuycC7PXXUt+dU+G/apMs1ge5prmNyfM21vio9X
        7N4rD+vPcv9TkTMQiuuU93WJPvP+rxGfy76ZbTOUz+/Rl/rmxevElM+3lsMqPDf9xWSxNqXd
        xQynhffL/WqbWH5tt13YIiWW4oxEQy3mouJEAEJml3RfAgAA
X-CMS-MailID: 20180515104009eucas1p15a587579dcd0085c82c9186d135463fb
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180501083748epcas4p15b1437f0c39447e7119c6397f624c0f5
X-RootMTR: 20180501083748epcas4p15b1437f0c39447e7119c6397f624c0f5
References: <CGME20180501083748epcas4p15b1437f0c39447e7119c6397f624c0f5@epcas4p1.samsung.com>
        <20180501083742.22565-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 01, 2018 09:37:42 AM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in error messages
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

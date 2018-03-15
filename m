Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932326AbeCONhW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:37:22 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:62243 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbeCONhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:37:16 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180315133714epoutp011ef4bdb564f25751d6fb41f4b33ff23f~cG4Whlc7a3174531745epoutp01I
X-AuditID: b6c32a48-9adff70000000ff0-92-5aaa77090370
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 17/47] fbdev: remove blackfin drivers
Date: Thu, 15 Mar 2018 14:37:10 +0100
Message-id: <3361512.ia3YxlrZJW@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180314153603.3127932-18-arnd@arndb.de>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7bCmhS5n+aoog++ndSz+TjrGbnHl63s2
        ixN9H1gtLu+aw+bA4vH71yRGj/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4MqYeWIqU0Ejc0X7
        O44GxgNMXYycHBICJhL/J51n62Lk4hAS2MEosfPRLmYI5zujRNP8fSwwVR+OnGEEsYUENjBK
        PN9aBVH0lVGi8fsFVpAEm4CVxMT2VWBFIgKKElNfPAOaxMHBLJAgsXuRGUhYWMBSYvXCb2Cb
        WQRUJSbP+cwOYvMKaEq8XbwXzBYV8JLYsq8drIZTwEziTct/NogaQYkfk++B3cMsIC+xb/9U
        VghbR+LssXWMIPdICExhk3j4bTsjxNEuEs9frGODsIUlXh3fwg5hS0s8W7URqqGZUeLbjj3M
        EIkJjBJ71gtB2NYSh49fhNrAJ9Fx+C87yDMSArwSHW1QJR4SsycchtrlKLH2xHZGSKBsYZR4
        N/8f2wRG2VlIDp+F5PBZSA5fwMi8ilEstaA4Nz212KjARK84Mbe4NC9dLzk/dxMjOOK1PHYw
        Hjjnc4hRgINRiYfXQG1llBBrYllxZe4hRgkOZiURXp+CVVFCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEedsCXKKEBNITS1KzU1MLUotgskwcnFINjAE/ay5dEOJw+13QJ8trffeWotpOscgry8JX
        Lux833198l/Z6iMzmm3fHj33Qunbs+lXz4kz3JV5Ok/i+fXE9Ut7UxqLV+7I7fjGnRaVl7G7
        8tv647tcjZetDjJinn025RD7oqO1qRMSv819P1WC1Vjt7bFUm/Wc57Z/mRP5uCtrEfPV3eW6
        zxKVWIozEg21mIuKEwEIpOC/9AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsVy+t9jQV2O8lVRBivumVj8nXSM3eLK1/ds
        Fif6PrBaXN41h82BxeP3r0mMHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJUx88RUpoJG5or2
        dxwNjAeYuhg5OSQETCQ+HDnD2MXIxSEksI5RYuuH7VDOV0aJzU0z2UGq2ASsJCa2r2IEsUUE
        FCWmvnjGDGIzCyRIrHjbzgpiCwtYSqxe+A1sKouAqsTkOZ/BenkFNCXeLt4LZosKeEls2dcO
        VsMpYCbxpuU/G8SyLYwSMxpOMEI0CEr8mHyPBWKBvMS+/VNZIWwtifU7jzNNYOSfhaRsFpKy
        WUjKFjAyr2KUTC0ozk3PLTYqMMpLLdcrTswtLs1L10vOz93ECAzSbYe1+ncwPl4Sf4hRgINR
        iYfXQG1llBBrYllxZe4hRgkOZiURXp+CVVFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEefnzj0UK
        CaQnlqRmp6YWpBbBZJk4OKUaGEuPtTA0iDh3XbEutZ2huL13ERPXLKPO52xCVm/+S/yrllp9
        s6lfbbbwtx7/RcKsJ2dsWpmu9rBpQ8q2nbfaNSzEfy/oeptvcC358KErf3+1cggJFsSd/DB7
        nQ1vx4zt95TfRL638WyZVRz29CK3dvPyrwUTdyyoissNyWU9ZFHv3GlwxTagXYmlOCPRUIu5
        qDgRABWnxUFOAgAA
X-CMS-MailID: 20180315133712epcas2p17f4afe280394b60dcd3307f98a063d5c
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180314154309epcas5p12bdd7c766b90b11522c0f6065c1da2e6
X-RootMTR: 20180314154309epcas5p12bdd7c766b90b11522c0f6065c1da2e6
References: <20180314153603.3127932-1-arnd@arndb.de>
        <CGME20180314154309epcas5p12bdd7c766b90b11522c0f6065c1da2e6@epcas5p1.samsung.com>
        <20180314153603.3127932-18-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 14, 2018 04:35:30 PM Arnd Bergmann wrote:
> The blackfin architecture is getting removed, this removes the
> associated fbdev drivers as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

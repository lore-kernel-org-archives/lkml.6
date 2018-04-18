Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbeDRPU3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:20:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10879 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeDRPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:20:26 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180418152023epoutp0143aea23134cf3e3ac11783bb28a2ed29~mkOHwV7nH2231722317epoutp01I
X-AuditID: b6c32a48-8d9ff70000000ff2-8c-5ad76236d7d7
Subject: Re: [PATCH] [media] include/media: fix missing | operator when
 setting cfg
To: Colin King <colin.king@canonical.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <ebce8e36-9125-aecb-b0d1-87f068646e67@samsung.com>
Date: Wed, 18 Apr 2018 17:20:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <20180418150617.22489-1-colin.king@canonical.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzs6Gi+PUfHFgNOyDUl5q2QHLruQJCgMJdAS69DA1p2NH
        RyrVMNG51EyZyCYWKGabwTanmIHZvBHpRhlZUo0yL6RGmOTyVm6HYN9+z/v8+PP84cURURs3
        As8rLKbVhfICCSZA+4ajjx1KvDYti/dsHiU3LXUY2TsjJu/NLiGk223lkZMVyzzSPvuOS04N
        tGJkrbWXS7a4Bzlkp32Lc0pAGbV1GGU312BUT8dtqt5hBtQve+RlrkxwPIcuyNPQ6rjkLEHu
        48k2RFWN3nBZ1jlaYEb0AMchIYW/rZgeCHAR0Q9gU30NYId1AFctTzh6wPdLI3dfcdnFMwDH
        5mZ47OABcKbdgfisEOIKHDL1+GNDiWjodql9DkJMcKCu5YffwYgEWDdaD3wsJJLhy7lRno9R
        4gDUf9z2cxiRDisW/vBYJxh6mz6jPubv+s19lf4cZDd/ca0RZTkcjnk+AJb3wZ7uFYS9egGD
        lpVItuY56HpBs88h8Pu4g8eyGM6bbYDlclhTpff3gkQlgFvNbzB2kQSHx19z2fw9UDfsu9OX
        KYS6KhGrUPCb4wvK8mloHnnkzxcR9wH02rIaQKQxoI0xoIExoIExoMFDgJrBXlrFKBU0c1gl
        jWXkSqakUBGbXaS0A/+viaH6wZDrohMQOJAECbNSp2UirlzDlCqdAOKIJFT4dPatTCTMkZeW
        0eqiTHVJAc04gRhHJeFC7aUJmYhQyIvp6zStotX/txycH6EFYm+rvVia+f7ITn+Yqb2rAUlL
        q079K/IgFQ/2Mwrd4Jn8r43CTluc5ucFWi81rbq2m4RdJxLvZARPOTPOZpcntaovx9dKuqOp
        jT4+brip0rgONi5zo8rXrVcNKdKyqLhbfQP00nlT+o4hZb5jMehkfoTNQK1tVLq8zz8ZNyQo
        kytPiEHUjPwfS06wTDEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsVy+t9jAV2zpOtRBisuSVr8Xt3LZrH1lrRF
        /+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbPo2bCV1WLG+X1MFss2/WFy4PKY1dDL5rFpVSeb
        x+Yl9R59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CVsfLsPOaCdpaKc6u/MzUwrmLuYuTkkBAw
        kTjSfZq1i5GLQ0hgJ6PEpVU9TBDOQ0aJH1PWM4FUCQuESuzacZuli5GDQ0RAU+L8uSKQGmaB
        M0wSMxbMZYdomMwosX/dNXaQBjYBQ4neo32MIDavgJ3EyadHweIsAqoSXXf+gtmiAhES985/
        YoOoEZT4MfkeC4jNCVQ/bVsLM8gyZgF1iSlTckHCzALiEsfu32SEsOUlNq95yzyBUWAWku5Z
        CB2zkHTMQtKxgJFlFaNkakFxbnpusVGBUV5quV5xYm5xaV66XnJ+7iZGYHxsO6zVv4Px8ZL4
        Q4wCHIxKPLwJ/tejhFgTy4orcw8xSnAwK4nw7nx8JUqINyWxsiq1KD++qDQntfgQozQHi5I4
        L3/+sUghgfTEktTs1NSC1CKYLBMHp1QDowpvgsaKOzPK9b3ulRT6SnW832zJqLx0e+HsmG/a
        m4pncaidqZgyZzNHD/8DvgmnHtvyCF8/ba7t63XhZQO3sOQrpxPbDPJOmy44/iRmN7PLs9UV
        1mmHzBpNLzn9uVS7LPlggFCqUGf57OnpzWb63sY9x94l1P3i2lozfeLVyoU+HtVHBMUOKbEU
        ZyQaajEXFScCAJDJ+liLAgAA
X-CMS-MailID: 20180418152022epcas2p363283e895d5673ad5da1313495f5e4b5
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180418150622epcas4p4be934b89937c0e50a2f236116c02d7cb
X-RootMTR: 20180418150622epcas4p4be934b89937c0e50a2f236116c02d7cb
References: <CGME20180418150622epcas4p4be934b89937c0e50a2f236116c02d7cb@epcas4p4.samsung.com>
        <20180418150617.22489-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 05:06 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The value from a readl is being masked with ITE_REG_CIOCAN_MASK however
> this is not being used and cfg is being re-assigned.  I believe the
> assignment operator should actually be instead the |= operator.
> 
> Detected by CoverityScan, CID#1467987 ("Unused value")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for the patch.

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

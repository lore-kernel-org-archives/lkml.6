Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeCONmC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:42:02 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:63254 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeCONl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:41:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180315134158epoutp01895a25f6b6ec956bab335e1af1d849c5~cG8eVFQA50173501735epoutp01G
X-AuditID: b6c32a48-9c5ff70000000ff0-fb-5aaa78258f28
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 18/47] fbdev: s1d13xxxfb: remove m32r specific hacks
Date: Thu, 15 Mar 2018 14:41:54 +0100
Message-id: <5285300.jRPGiOpfO7@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180314153603.3127932-19-arnd@arndb.de>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCmha5qxaoogw8b1S3+TjrGbnHl63s2
        i3knJSxO9H1gtbi8aw6bA6vH71+TGD12zrrL7nG/+ziTx+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        78+eZSp4xFQxd+4JpgbGpUxdjJwcEgImEqcvL2LvYuTiEBLYwSjxfs4tFgjnO6PEy863bDBV
        l/9uZ4RI7GaUmPXzMlTVV0aJ/qtzmEGq2ASsJCa2r2IEsUUEFCWmvnjGDFLELDCVUWLZhNPs
        IAlhAQ+JaddvsYLYLAKqEseebQSyOTh4BTQl/vZrgYRFBbwktuxrB7uPU8BM4nzfJbCZvAKC
        Ej8m32MBsZkF5CX27Z/KCmHrSJw9tg7sOgmBNWwSe/c1MkKc7SLx89YBZghbWOLV8S3sELa0
        xLNVG6Eamhklvu3YA1U0gVFiz3ohCNta4vDxi1Ab+CQ6Dv9lBzlUQoBXoqNNCML0kOj8bghR
        7Shx8/VpsNuEBLYAg26fxQRG2VlIzp6F5OxZSM5ewMi8ilEstaA4Nz212KjARK84Mbe4NC9d
        Lzk/dxMjOAloeexgPHDO5xCjAAejEg+vgdrKKCHWxLLiytxDjBIczEoivD4Fq6KEeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ87YFuEQJCaQnlqRmp6YWpBbBZJk4OKUaGOvOZJ7KW8Wp+LlRRFhw
        ql21gK4L03O94h8LFotxJDh13ahkfy3LZOM8u3/+7idha/hnsapWn4re/1p8C8trgSNHs8M9
        7cy/zhRvytouc6mvyyM4Ri6+Q89gy+5gDelvusLOE3WYNGbXnuH/Il7K8uDp9J2ulgs2KAaI
        T5yX5CumVvilsrlUiaU4I9FQi7moOBEAt85aEv4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t9jAV2VilVRBtuuyFn8nXSM3eLK1/ds
        FvNOSlic6PvAanF51xw2B1aP378mMXrsnHWX3eN+93Emj8+b5AJYorhsUlJzMstSi/TtErgy
        3p89y1TwiKli7twTTA2MS5m6GDk5JARMJC7/3c4IYgsJ7GSU6G3OhLC/Mkr87VcHsdkErCQm
        tq8CqxERUJSY+uIZcxcjFwezwFRGiXNXm1hBEsICHhLTrt8Cs1kEVCWOPdsIZHNw8ApoAs3R
        AgmLCnhJbNnXDraXU8BM4nzfJUaQOUICWxgllt2eygKS4BUQlPgx+R6YzSwgL7Fv/1RWCFtL
        Yv3O40wTGPlnISmbhaRsFpKyBYzMqxglUwuKc9Nzi40KjPJSy/WKE3OLS/PS9ZLzczcxAoN2
        22Gt/h2Mj5fEH2IU4GBU4uE1UFsZJcSaWFZcmXuIUYKDWUmE16dgVZQQb0piZVVqUX58UWlO
        avEhRmkOFiVxXv78Y5FCAumJJanZqakFqUUwWSYOTqkGRpOrckXM/y2cditzLrn3WN18993V
        9897imlVSP7J4zm+Z90b+RKn/Inph6zimKKLHl/2+7PW/YoZ37aPls8Dz4iqPKiND9TPyf7Y
        d+Dt1afi87dsufG++NqNYP20Q7O/feetMS+X3Lpn4adrFyYfmf/qa+tVh13vI4JCVFLt3/ju
        k1Zxv66tIqPEUpyRaKjFXFScCABWKyXMVgIAAA==
X-CMS-MailID: 20180315134156epcas2p4f2114d5d1d223423ddf6768e1de656b4
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180314154316epcas4p4ae29df0d379f48b4b8272cca0c757560
X-RootMTR: 20180314154316epcas4p4ae29df0d379f48b4b8272cca0c757560
References: <20180314153603.3127932-1-arnd@arndb.de>
        <CGME20180314154316epcas4p4ae29df0d379f48b4b8272cca0c757560@epcas4p4.samsung.com>
        <20180314153603.3127932-19-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 14, 2018 04:35:31 PM Arnd Bergmann wrote:
> The m32r architecture is being removed, so this is no longer needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

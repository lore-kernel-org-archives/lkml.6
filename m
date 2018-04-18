Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeDRPXg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:23:36 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:23115 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDRPXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:23:33 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180418152330epoutp04e827eb57993c7dfaa364ec20b188a808~mkQ1xLB5-2228322283epoutp040
X-AuditID: b6c32a45-6ebff70000000fe4-e5-5ad762f236e9
Subject: Re: [PATCH] [media] include/media: fix missing | operator when
 setting cfg
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: Colin King <colin.king@canonical.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-id: <bafbcf6c-a08d-11ba-af25-655b7cc44e1c@samsung.com>
Date: Wed, 18 Apr 2018 17:23:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <ebce8e36-9125-aecb-b0d1-87f068646e67@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7bCmue6npOtRBhs+ylj8Xt3LZrH1lrRF
        /+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbPo2bCV1WLG+X1MFss2/WFy4PKY1dDL5rFpVSeb
        x+Yl9R59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CVceLCavaCr6wV6zrZGhhfs3QxcnJICJhI
        fH39krmLkYtDSGAHo8SNZY3sEM53RolZ/07BVf1c+AGqagOjxL6996Gq7jNKrHy/lxmkSlgg
        VOLA7M1gNpuAoUTv0T7GLkYODhEBTYnz54pA6pkFzjBJdMx4B1bDK2An8XLpLHYQm0VAVWLm
        vxdgtqhAhETT85/sEDWCEj8m3wO7glPAXuLFvw2sIDYz0MwXXyaxQNjiEsfu32SEsOUlNq95
        C3aphMBzNom+bwtYIV5wkTh4dTkjhC0s8er4FnYIW1ri2aqNUPFqic62LnaI5hZGiT/TLrFB
        JKwlDh+/CLWZT6Lj8F92kM8kBHglOtqEIEo8JJ5seQgNLkeJVUeWQ0PoGKPEptn7mCYwys1C
        8tAsJE/MQvLELCRPLGBkWcUollpQnJueWmxUYKhXnJhbXJqXrpecn7uJEZxwtFx3MM4453OI
        UYCDUYmHN8H/epQQa2JZcWXuIUYJDmYlEd6dj69ECfGmJFZWpRblxxeV5qQWH2KU5mBREudt
        8D0TJSSQnliSmp2aWpBaBJNl4uCUamBkSmuymadvu3JH+9nlAd9tsybnmKzmOM3waqfsJIG2
        D7859zEFFRlnJMrPurMh6blTGMOt6U3+rR2VyySmFb9VNpuXvtRuq+KH2bKcJ7fs33760Aq5
        brEDmvarXnwUjJy1ZfHrx8d+pn1RPXli1f/ONRmX/TfaWVuXFR3eeSljm4qb8ov/IatClFiK
        MxINtZiLihMBXYs1JjQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsVy+t9jQd1PSdejDLbOYbP4vbqXzWLrLWmL
        /sevmS3On9/AbnG26Q27xabH11gtLu8CqujZsJXVYsb5fUwWyzb9YXLg8pjV0MvmsWlVJ5vH
        5iX1Hn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJVx4sJq9oKvrBXrOtkaGF+zdDFyckgImEj8
        XPiBuYuRi0NIYB2jxIazR1khnIeMEncvzWIGqRIWCJXYteM2WAebgKFE79E+xi5GDg4RAU2J
        8+eKQOqZBc4wScxYMJcdovkEo0TfmelsIA28AnYSL5fOYgexWQRUJWb+ewFmiwpESNw7/wmq
        RlDix+R7YAs4BewlXvzbwAqygFlAXWLKlFyQMLOAuMSx+zcZIWx5ic1r3jJPYBSYhaR7FkLH
        LCQds5B0LGBkWcUomVpQnJueW2xUYJSXWq5XnJhbXJqXrpecn7uJERgd2w5r9e9gfLwk/hCj
        AAejEg9vgv/1KCHWxLLiytxDjBIczEoivDsfX4kS4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsuf
        fyxSSCA9sSQ1OzW1ILUIJsvEwSnVwBg193BM+X3ZRvFnd3ZJnfv+cKGPSe3+mSUTg2pjrrAd
        uSM1bdHjp/EGwvZJSyadmCPjU7Xmx2Klc9rpU3Ke6xlmn71tfIznSkk3402/y+tz2H3VMj0D
        evXXzLTZuzS0fN+MQ3qqU1I2RAmrHNvJqCa8/Xdg4mPND1uEtDRTS0w0S+Wm655s1FFiKc5I
        NNRiLipOBAAN6tyqigIAAA==
X-CMS-MailID: 20180418152330epcas2p4b951827d330abddeb46a48a21dc75f62
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180418150622epcas4p4be934b89937c0e50a2f236116c02d7cb
X-RootMTR: 20180418150622epcas4p4be934b89937c0e50a2f236116c02d7cb
References: <CGME20180418150622epcas4p4be934b89937c0e50a2f236116c02d7cb@epcas4p4.samsung.com>
        <20180418150617.22489-1-colin.king@canonical.com>
        <ebce8e36-9125-aecb-b0d1-87f068646e67@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 05:20 PM, Sylwester Nawrocki wrote:
> On 04/18/2018 05:06 PM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The value from a readl is being masked with ITE_REG_CIOCAN_MASK however
>> this is not being used and cfg is being re-assigned.  I believe the
>> assignment operator should actually be instead the |= operator.
>>
>> Detected by CoverityScan, CID#1467987 ("Unused value")
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Thanks for the patch.
> 
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I forgot to mention that the subject should rather looks something
like:

"exynos4-is: fimc-lite: : fix missing | operator when setting cfg"

-- 
Regards,
Sylwester

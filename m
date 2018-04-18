Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeDRH5k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:57:40 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58378 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeDRH5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:57:38 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180418075736epoutp0332a75d1a9ae7bdfd828945e09f681865~meLguYgyr2545825458epoutp03Z
X-AuditID: b6c32a35-151ff70000000fee-14-5ad6fa6f183a
Mime-Version: 1.0
Subject: RE: Re: [PATCH] PM / devfreq: use put_device() instead of kfree()
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
        arvindY <arvind.yadav.cs@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <5AD01937.1070504@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180418075735epcms1p3c59f097441aabc6af5d7892298c6fdb2@epcms1p3>
Date: Wed, 18 Apr 2018 16:57:35 +0900
X-CMS-MailID: 20180418075735epcms1p3c59f097441aabc6af5d7892298c6fdb2
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180418075735epcms1p3c59f097441aabc6af5d7892298c6fdb2
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmvm7+r2tRBo1fLCyu9S5ktrj+5Tmr
        xdmmN+wWl3fNYbP43HuE0YHVY+esu+wefVtWMXp83iQXwByVapORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYqsUbWhopGdoYK5nZGSkZ2Ica2VkClSSkJqx8MgaloK9AhWvX81gbmBsEehi5OSQEDCR
        OPL8IFsXIxeHkMAORokHMw+ydDFycPAKCEr83SEMUiMs4CXxe9oOZhBbSEBJouHmPmaIuL5E
        x4NtjCA2m4CuxNYNd1lAbBGBKokXtw6C2cxA9pO5Z9ggdvFKzGh/ygJhS0tsX74VrJdTQFvi
        xM+77BBxUYmbq9/C2e+PzWeEsEUkWu+dZYawBSUe/NwNFZeSePJ2IVR9vcT1z4uYQH6REJjA
        KPH7xn+ohL7EoyuzwY7gFfCV2P3mOFicRUBV4un+ViaIGheJDRMhDmIGOmjZwtfMoHBgFtCU
        WL9LH6LEVuL+/kmsECV8Eu++9rDC/LVj3hOoMWoSh3YvgVorI3F6+kKomz0kns27A2U7SjSs
        Xcg+gVFxFiKkZyFZPAth8QJG5lWMYqkFxbnpqcWGBYZ6xYm5xaV56XrJ+bmbGMHpTst0B+OU
        cz6HGAU4GJV4eBcIXIsSYk0sK67MPcQowcGsJMK78/GVKCHelMTKqtSi/Pii0pzU4kOMpkD/
        T2SWEk3OB6bivJJ4QxNLAxMzI2CKszQ0VBLnfepzJkpIID2xJDU7NbUgtQimj4mDU6qB0UKc
        97uqaFJ69eEzFQmMjR3FD0L21v2d9vZ6a+rJ/ttamulhIaGb/Pv93nS3vIxL2f/qe69q8AbG
        P/bnT3+aVHX+U8ZO47Ls6/OtJx2O54wU+toTuOXA6jfXrm9WiUpdrDL3YtKdlG3iD6U3i01+
        Gfu5UW6VwWTtsNm3g2ZzzV/Gtdd/tWTpLiWW4oxEQy3mouJEAIHV8rmNAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be
X-RootMTR: 20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be
References: <5AD01937.1070504@samsung.com>
        <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
        <5AD001C5.2040406@samsung.com> <5AD0041D.2050506@samsung.com>
        <5AD012CB.7030003@gmail.com> <5AD0160E.7050601@samsung.com>
        <5AD017E8.7020901@gmail.com>
        <CGME20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3I7vj6I014099

>On 2018년 04월 13일 11:37, arvindY wrote:
>> On Friday 13 April 2018 07:59 AM, Chanwoo Choi wrote:
>>> On 2018년 04월 13일 11:15, arvindY wrote:
>>>> On Friday 13 April 2018 06:43 AM, Chanwoo Choi wrote:
>>>>> On 2018년 04월 13일 10:03, Chanwoo Choi wrote:
[]
>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>>> index fe2af6a..a225b94 100644
>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>> @@ -625,7 +625,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>>        err = device_register(&devfreq->dev);
>>>>>>>        if (err) {
>>>>>>>            mutex_unlock(&devfreq->lock);
>>>>>>> -        goto err_dev;
>>>>>>> +        put_device(&devfreq->dev);
>>>>>>> +        goto err_out;
>>>>>>>        }
>>>>>>>          devfreq->trans_table =    devm_kzalloc(&devfreq->dev,
>>>>>>> @@ -671,6 +672,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>>        mutex_unlock(&devfreq_list_lock);
>>>>>>>          device_unregister(&devfreq->dev);
>>>>>>> +    devfreq = NULL;
>>>>>>>    err_dev:
>>>>>>>        if (devfreq)
>>>>>>>            kfree(devfreq);
>>>>>>>

Ah.. this was critcal. Thanks!

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


Cheers,
MyungJoo

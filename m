Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C365CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9603E222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I8heGaJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391555AbfBMTHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:07:39 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:54992 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbfBMTHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:07:39 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190213190735epoutp042c93460454aa32ccaf2c323533c4c9bf~DAfare_eu1857018570epoutp048;
        Wed, 13 Feb 2019 19:07:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190213190735epoutp042c93460454aa32ccaf2c323533c4c9bf~DAfare_eu1857018570epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550084855;
        bh=6grVh9ZEFkBzyE5/1BQVpDAnCDB4ws3Y/AZzXjH4los=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=I8heGaJX6Qe6P908s12YddHkO9OYPsyzcas/MGyZexafB8Yuy9/jSwAxfchn1W6aW
         G/VfcaSZGUysW01GvMlicUMLV40+gqzv8RArxRosi2LtDP+UIVjG3eNrIq0c7nfeii
         tlz6f2Yrg3ZaxUl0gXcJ1pToS0tuTrSNkk3LATWY=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190213190735epcas1p15f6fa86885d08e12d52fb3a3c63bc2cd~DAfaSzWW51976019760epcas1p1G;
        Wed, 13 Feb 2019 19:07:35 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.AD.04069.7FA646C5; Thu, 14 Feb 2019 04:07:35 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190213190734epcas1p256438b96302a435c4e32eb87d55deb91~DAfZ-ooW43124231242epcas1p2A;
        Wed, 13 Feb 2019 19:07:34 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-71-5c646af75048
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 4F.3F.04015.6FA646C5; Thu, 14 Feb
        2019 04:07:34 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMV0084YP4IH510@mmp2.samsung.com>; Thu, 14 Feb 2019 04:07:34 +0900 (KST)
Subject: Re: [PATCH v2 18/21] ASoC: samsung: i2s: Comments clean up
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <8e68b53f-5e19-c686-dd37-8f730ae1c256@samsung.com>
Date:   Wed, 13 Feb 2019 20:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <CAJKOXPeSYf8bHNSnpvK1X=cCV=_JxzN_bKdvN9a+RCEqBfK3hQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZdlhTT/d7VkqMwZT9PBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLiyu+MDlwemz43MTmsXPWXXaPTas6
        2Tz6tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoEr49TJj8wF01grGm59Z2xgfMHcxcjJISFgItHe
        sY+1i5GLQ0hgB6PE7Zd3oZzvjBIHl51mganau3EaE4gtJLCBUaJ/vh9E0X1GieO9P9hAEsIC
        zhJPLy4HaxAR0JS4/vc72CRmgTNMEjd6LjGCJNgEDCV6j/aB2bwCdhKb/j8Bm8oioCrRuf0v
        O4gtKhAhcbj3HVSNoMSPyffAhnIKBEusvLkWbBkz0IIXXyaxQNjiEsfu32SEsOUlNq95ywyy
        WELgMZvE464bQA4HkOMicXsiE4QpLXHpqC3EY9USu7Z3Q5V3MEq0XNgODRdricPHL7JCzOST
        ePe1hxWil1eio00IosRDYs7T40yQgOhkktj7fSnzBEaZWUjOnoXk1FlITp2F5NQFjCyrGMVS
        C4pz01OLDQuM9YoTc4tL89L1kvNzNzGCE4eW+Q7GDed8DjEKcDAq8fBWCKXECLEmlhVX5h5i
        lOBgVhLh1YsCCvGmJFZWpRblxxeV5qQWH2KU5mBREudd7+AcIySQnliSmp2aWpBaBJNl4uCU
        amCsrZw0z9F0xv0V6bayJruezEj3ni1vU/tYZGdLO9+05UrFZsq6F38H114WLp/mc9r4TIb+
        oaSiL/nW7urXNE808ZtcD/bJ4uk3ffF+xjVjzgkZ2wx6Rd69z+PaPSWOgf3X7aTj3WGRadxX
        2kQnGSR1+wZb2L1deqDVhz9304v0S+UNZ5deZ1BiKc5INNRiLipOBADgdfGCGAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t9jQd1vWSkxBsd2GVtcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktLq74wuTA6bHhcxObx85Zd9k9Nq3q
        ZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujFMnPzIXTGOtaLj1nbGB8QVzFyMnh4SAicTe
        jdOYuhi5OIQE1jFKvJt3FiwhJPCQUaKtVQ3EFhZwlnh6cTkLiC0ioClx/e93VpAGZoEzTBKv
        1jxnh+juZpKY3reQDaSKTcBQovdoHyOIzStgJ7Hp/xMmEJtFQFWic/tfdhBbVCBC4uPTfUwQ
        NYISPybfA9vAKRAs8XrWT6BeDqAN6hJTpuSChJkFxCWO3b/JCGHLS2xe85Z5AqPALCTdsxA6
        ZiHpmIWkYwEjyypGydSC4tz03GKjAsO81HK94sTc4tK8dL3k/NxNjMDI2HZYq28H4/0l8YcY
        BTgYlXh4FQRSYoRYE8uKK3MPMUpwMCuJ8OpFAYV4UxIrq1KL8uOLSnNSiw8xSnOwKInz3s47
        FikkkJ5YkpqdmlqQWgSTZeLglGpgbLxX868zZKP4Mh7VS5kOyTanuO8+vzvvk2RKNcMnkwPz
        zy6967K/l/WlgaBeUMS537t3zJoa8Xyr7CS16MSMxVM6Lm4wTQ7c57pjS1r83meHNdijvuTe
        O96xTmRbhJbxrVW3C6/POKiXeO/3iSW+ycYHnl7rEGN0dTjuaMF358Cca9LdT/LrTJVYijMS
        DbWYi4oTAcvUjZSIAgAA
X-CMS-MailID: 20190213190734epcas1p256438b96302a435c4e32eb87d55deb91
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180542epcas2p2f7252babc9b4dc97eaaa214658afe5d0
References: <CGME20190212180542epcas2p2f7252babc9b4dc97eaaa214658afe5d0@epcas2p2.samsung.com>
        <20190212180342.32040-1-s.nawrocki@samsung.com>
        <20190212180342.32040-19-s.nawrocki@samsung.com>
        <CAJKOXPeSYf8bHNSnpvK1X=cCV=_JxzN_bKdvN9a+RCEqBfK3hQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 09:06, Krzysztof Kozlowski wrote:
>> @@ -742,7 +742,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
>>         switch (params_channels(params)) {
>>         case 6:
>>                 val |= MOD_DC2_EN;
>> -               /* fall through */
>> +               /* Fall through */

> Just to be sure - did you check whether this passes GCC
> -Wimplicit-fallthrough=3 (you need GCC v7)? It looks correct - like
> one of accepted patterns
> (https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html).

I just checked it now and with comment in upper case the warning 
is also being suppressed.

-- 
Regards,
Sylwester

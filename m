Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FE6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E9323F12
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E9323F12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753858AbeGBJlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:41:12 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeGBJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:41:10 -0400
Received: from [192.168.1.110] ([89.15.130.186]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0LvBCM-1gIEFC3KRW-010Kai; Mon, 02 Jul 2018 11:41:08 +0200
Subject: Re: List of devices with poor Linux compatibility
To:     Andrey Ponomarenko <andrewponomarenko@yandex.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2047231529565676@web41o.yandex.ru>
From:   Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <53f2c691-b445-6758-79bf-b8902b7f008a@metux.net>
Date:   Mon, 2 Jul 2018 11:41:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2047231529565676@web41o.yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9BAg5l+kEpR1Oy0NzJA69EXuK7wqiM2gcN4+C1yety8kLJ98vK1
 TOBjwxaWmCNJXt//4e3nLOP0WPBsqAhxNoD3adNnF0XZKaqoWRpNfae0w4GWid7ihhR+U1B
 2wbrfPZTzSWYg3/0LZUgjKibAs9+yBbmc6L/Pr/noiskcqDrlGcMWuOcM9QcnCpUaLR0MwG
 XTPO0ZSPCHpZcFq0MnfZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dacMP1pMVQk=:uLTm/c8S8ph/3+MnvvhTUJ
 5qww4ecVGDzRTX7nnvTNIU8RCVXgOyyZS2ZsqAYfrabRCGwrgl2YJOWVnfDTN249zP6a8TN3q
 l+CA3TE1IjY5yTZ24dKhwy2od35ny1Aua24si6lod2/s/BkS6r9PDO9mtNkfjRIZIZCDYjqd1
 Hg0fjEuvRVvTozg14XjOTcHzF1jdL82F7NtuoJn1O5Q9KQ1/gKsnTi2+9CejBm4hs44uSqDkK
 99L+ZUz9LY5k59G9i5DI8WB7g0J2BHsj2GQXv0VbvvGVauufPaYyXPqlmWU44FczW9pwRk7sd
 zRf9Knj4Ypcg/IR4Yt4O5swqBIN1vwRQ43+fFMYLD7Sk2LJ1XU9GjGE5kRP+e0/8di1aTTSnf
 6accU/lcCGTQkyFNJYKAfRzQnOKRqEUNM2Pg+96q9MvLZPxunEudogCvzLIJ8UsdpV1FkqSWX
 RGRqbTv9TI/igsOzglirrC1MmK2FlCMOzeaeL8LGv/pLgUvbGLnQytL8TaIrYvKIrUod9ebPP
 E+LRWzKcnJJmBwChZY/JCJ5jeJoTwzUIFd3UgGp6lC/dTMt9zbAlLd7r+n78VJBCJUW+Uotzt
 ipEUZJ3pC8fnGMDbi2ueroFzM7J4Dg18gG13Uo3JTC8Rn5L19zJ9gqIIrhs2FaZe6kF7Brxwo
 3dWlLmLI6S3z4CEdOuE9c9fmb8GB4GfWvFZG+L6EuvqMZldL2Yaq7nVHbc4FD0JMHCwuU7M3F
 XmXexY21s+pC0VWW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.2018 09:21, Andrey Ponomarenko wrote:
> Hello,
> 
> A new open project has been created to collect the list of computer hardware devices with poor Linux compatibility based on the Linux-Hardware.org data: https://github.com/linuxhw/HWInfo

You can add most of the National Instruments hardware
(except those few which are supported by iio/comedi).

NI itself doesn't have any actually usable Linux support
(not even on ther Linux based cRIO controllers :o)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A729C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 18:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB9520878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 18:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB9520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbeG1T3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 15:29:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:48815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbeG1T3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 15:29:22 -0400
Received: from obelix.fritz.box ([87.122.99.93]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVeCF-1fTpyN03A7-00YwSR; Sat, 28
 Jul 2018 20:01:48 +0200
Subject: Re: Linux 4.17.11
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <3a976c32-555b-ab68-3e2d-d5fbe7743d58@gmx.de>
 <1f5cc630-9390-7392-f2dc-fb9d84937179@infradead.org>
From:   "rwarsow@gmx.de" <rwarsow@gmx.de>
Message-ID: <fad1f28f-0229-8af1-124f-8cb4d43e25eb@gmx.de>
Date:   Sat, 28 Jul 2018 20:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1f5cc630-9390-7392-f2dc-fb9d84937179@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RgvV5o6J3uYnnXHy0vo/dArLNg+b32NHke0IjCbq4T/dWdfpOzt
 igyuZsNaCaDQ8m28ypd8pbgT90X4hCJD0fWV+FQoSt+jPLBFqhvaR2jDmyvBKJoRnlyBFe1
 AxEE7UgA4WNiOxV94swXX3MdulYW3eOrrMYG4qiCHMnGlyRmO7lPEGn5c1sZ0R+Ju0JmX3r
 GMyKIUf950NPcEIWzR0Jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YtxQfdBYSD8=:oqrLwBWay8TizjxO5+pQuP
 rOrrCUzWJo0HaZJTlc7Al6fHEa1Duvfp2JH+MmplWCOR+DvUYmh0L7NXPuKN0wbBnXJf7P+Vv
 MM1PYG3IybWd66ZXHBmp+JlT9cYDGe5uDwSwFokpD12hc7mQWe+DkTptDj0UBcmveuI+nZP8/
 BPVe9qC5GNQFgJuM0bv7GxBolNSGY0zHvcX0pK2WwrNWjeOqaFtd2zA8ek3qIe9rFxrXm9WCE
 JMEncEO78WaYS5R11hJvVY/5gFJ9gAIPb+6GSpekf46o1IvQzp+BLWYgQt5pWfWE+VkNp+7c8
 z5blFVl2MzCx9YF/Nh/TYi2mvWBGfSORqprl6MIOkwgstwrhG2K1DcaDlEuk6a3UoPywhp00C
 9c46/MXL7MyyvDjEG796YLoeZdRaToABUOgd9rfCIP3rDV8BwoXwQ2vkLnHdDGR+mLIfIe7vK
 UHcx4j3LIpYruqcEb5+xFqdjk25vWeHMNAv4Fh7FyCJHEE/QqpQzufRZaSsXiGPdIeyWEMXKu
 KLVlHr4//R9uMvjWk2ZzSXDqfJDMShP/ptXDdFaCSlVc0f6aHi/wC2UcEGDaW7P/TND428hVs
 bUJNWFvizM6RNeedUjFpRamgeL8uIhUd85gM3ZNA+PvqNVBWl9gTPOufqc6C5lLbld749QFCa
 bon28+FwzOiF5H+wU5TFKOuZ5w+msJUHQ2cMR+gQuXtNhMI1Hi0sq3ABy7OlnFLuXfk/4dCQM
 CiE5rU3QWB494ERrh49LO2gzv2TuAB0pAx7Vq0Fn6OV+An+T0ItGPpsLfLxK0BcSsugIyPUNZ
 si8G5uR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.2018 18:59, Randy Dunlap wrote:
> On 07/28/2018 09:50 AM, rwarsow@gmx.de wrote:
>> Hallo
>>
>> I see this since 4.17.11:
>>
>>
>> [    0.282161] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
>> [    0.282269] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
...

>>
> 
> Looks like the same problem that Linus reported.
> A patch has already been posted for it here:
> https://lore.kernel.org/lkml/CF6A88132359CE47947DB4C6E1709ED53BB4FB62@ORSMSX110.amr.corp.intel.com/
> 
> It seems to just be noise.
> 


Okay, thanks for quick support !

-- 
greetings

Ronald

Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8824C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA44020825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA44020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeKJL3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:29:06 -0500
Received: from mout.gmx.net ([212.227.15.18]:50359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbeKJL3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:29:06 -0500
Received: from [74.104.183.64] ([74.104.183.64]) by
 msvc-mesg-gmx021.server.lan (via HTTP); Sat, 10 Nov 2018 02:45:29 +0100
MIME-Version: 1.0
Message-ID: <trinity-be6414fb-25ba-4881-acc6-abe3b375d0d0-1541814329304@msvc-mesg-gmx021>
From:   "Qian Cai" <cai@gmx.us>
To:     "Waiman Long" <longman@redhat.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Yang Shi" <yang.shi@linux.alibaba.com>,
        "Zhong Jiang" <zhongjiang@huawei.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: ODEBUG: Out of memory. ODEBUG disabled
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 10 Nov 2018 02:45:29 +0100
X-Provags-ID: V03:K1:wcZcI1ptzWNkj612oU4jOc6rhcXVY4WbWRLdsqhpl0TLpGNOWpoXSi/7utgRSJn0fmU5s
 JjCbTvOfR7veYUXRLnJk561Spx35X7ZMJUuzzEqpbgJ/fTupjuwoyPzqqm9gz88A6fMrpupYsD2b
 kgzs9ecK/uBEtWdrQcyl21858SrxNze2PpOghH5EqEy8DvGIMTS9MunCYA05Q+7oV0OrviPJH6Jg
 KQEmIa2FEKu5ekr1d32KwsgCpGECd2/fZtSJqo6/LSlkYr7StvWTQi+FEp7sDCj2FioZpsUMa516
 6OiSMIbAV+HV2/c6pt+WKDX
X-UI-Out-Filterresults: notjunk:1;V01:K0:ROSJ56+HW60=:3uQwSd7HnoisoazMA3W8vD
 aovvuM6VVtjAezmAVziS4VqH3T70gw1eqL5mmMN3j9CRFEpNROu0YoYYEyBtHCCCPbY/fUAjZ
 99rdJp44JPlsvH8P4+EGnU5gTjaikltjvuKN0r1ugxSbOSyHc7yHp4JXitZHH55vMBcuAxGTp
 KUwUqrUS0eYt2P+4sEnckjGC+iL3HDaWwFuVP7OcAnU3H1wfBgI+KFrKSqi2Brdjyb0BX0xfP
 qNA2bMdKUqYnIhh+Gz3wXLliSSMObRsLp37UPvunABKubyEX7UjxxMf2nz6JQ299hzZAQVV5a
 yuGRuec26zq1xFH0iNe1G9+soESS7sJPTOvibO96Efim/2u3rS7XgPyEJYB45GkuUDbFYyQHv
 tvg/rJC+jwvO43YIKrThgVIO2h+Q0ZrCvGMTuqD5Oc2Gjz5+qL+TEpsduEEdRPlXW5x2aLhBv
 fcNEaGJI5M5ACGk28ZJMgJQFg70SkT35oDrPr/Yd+NFuPiuGkTcvGxeznYFxneWxdajY77S9A
 2PrcO0AOrajnPp/jtopMew87y9jKzdIWAZB4DdlSvKn9S3TV6QH/QKdXwFJCpTP9IZP2CynhN
 09EdxBPK2uehfoTjYlbApggIjbAfsmx7sQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sent: Friday, November 09, 2018 at 5:08 PM
> From: "Waiman Long" <longman@redhat.com>
> To: "Qian Cai" <cai@gmx.us>, "Yang Shi" <yang.shi@linux.alibaba.com>
> Cc: "open list" <linux-kernel@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Arnd Bergmann" <arnd@arndb.de>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Zhong Jiang" <zhongjiang@huawei.com>
> Subject: Re: ODEBUG: Out of memory. ODEBUG disabled
> 
> On 11/09/2018 04:51 PM, Qian Cai wrote:
>> 
>>> On Nov 9, 2018, at 4:42 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>> 
>>> 
>>> 
>>> On 11/9/18 1:36 PM, Qian Cai wrote:
>>>> It is a bit annoying on this aarch64 server with 64 CPUs that is
>>>> booting the latest mainline (3541833fd1f2) causes object debugging
>>>> always running out of memory.
>>> May you please paste the detail failure log?
>> I assume you mean dmesg.
>> 
>> Here is the dmesg for 64 CPUs,
>> https://paste.ubuntu.com/p/BnhvXXhn7k/
>>>> I have to boot the kernel with only 16 CPUs instead (nr_cpus=16)
>>>> to make it work. Is it expected that object debugging is not going
>>>> to work with large machines?
>>> I don't think so. I'm supposed it works well with large CPU number on x86.
>> Here is the one with nr_cpus workaround,
>> https://paste.ubuntu.com/p/qMpd2CCPSV/
> 
> The debugobjects code have a set of 1024 statically allocated debug
> objects that can be used in early boot before the slab memory allocator
> is initialized. Apparently, the system may have used up all the
> statically allocated objects. Try double ODEBUG_POOL_SIZE to see if it
> helps.
Great, you are right. Doubling the size makes it work. Does it make sense
to have a kconfig option instead?
> 
> There are also quite a number of warnings in your console log. So there
> is certainly something wrong with your kernel or config options.
Yes, I am working on all those warnings. This one is found by ODEBUG,
https://lkml.org/lkml/2018/11/10/136

Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63920C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315482089F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315482089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeKNK5N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:57:13 -0500
Received: from mout.gmx.net ([212.227.17.22]:50623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbeKNK5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:57:13 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LlqNY-1fnfhd2Zvs-00ZSxv; Wed, 14
 Nov 2018 01:55:57 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: ODEBUG: Out of memory. ODEBUG disabled
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <FE1B58AA-FC0E-4E0A-8A76-F98B70548F36@gmx.us>
Date:   Tue, 13 Nov 2018 19:55:55 -0500
Cc:     Jan Stancek <jstancek@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Du Changbin <changbin.du@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <BD191D62-A66F-442C-94FD-13806C94A4A1@gmx.us>
References: <trinity-be6414fb-25ba-4881-acc6-abe3b375d0d0-1541814329304@msvc-mesg-gmx021>
 <c7b58543-ffd2-44bb-1005-e9733782bad5@redhat.com>
 <trinity-0da197a3-0f6e-41a3-8ab7-a3519e158a88-1541859073829@msvc-mesg-gmx023>
 <FE1B58AA-FC0E-4E0A-8A76-F98B70548F36@gmx.us>
To:     linux kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:Zq6Gr13QYWhCXkwlVrxpTorEw4+6wglMiFN7Pytd2rMWuj5k9Mw
 bhRCKQCXrG8UCjKsAn5rvitMSWUXoGi1E0Rj50pu1wuxCj5zoeBAHG/1xOFysO8Oe8PdRs+
 +2gEWEyZSE/wS+3zzlWNC2oMqdt51aKuG3/GBJlUyRjY3VLxZCfucH6Z4+84oExmRpEx1QW
 HQPAII/jrQaSVgkcAtDWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZjtxYxf1h60=:13zVrbKI3pCkh4OdQy+ZbZ
 Rc7Zo/5zcD27ykkypWOtNkHYzDMzKAhi+WvFibH6FzhewFI5axhoaIwYR+ZX/jhwucwOOSGSx
 NmAkD5J9DT46p7JDMSLH8X73UnjhjnesRswMZHdPcq5nlpYi5FAtfcNvGNJc7toSfah21Pbxz
 MUA9iKWvj9yWNYbwu0y3Yg8ff2yaZL86wnfKfghobDotC+ddxJpX9Tgcry1NVUOlujz7h35Ty
 mXo/AWzeR7q3fqHRsE41eIQ1G6FzfxuqtOfEJjZ51mSNY3OIMoO3anSHJ/l1lqkLBKIGdeYw7
 am+gQdXk2sZrdsFsiB3hpmEje1dcLANI81kNokudodehjdkj7vAOCyE2dSst6jk8gtn1tx/Z5
 r1ffbNLMflhPWhQEbTLS4sZAQ8slmnt3r+M2q6SS+YloNy97omgudAvXt/JvtesF6wTUg8wua
 k3oqDMrYWORbrGTg54ATGI0aJftRx15cj9hF9iaDp8ZX3XS37oFJplPzaTwj8XiF1JHmZymL9
 1pyKlgCJ93RbH11dCnezJqO6a1Be0bQN47yturEXJpBNMpJbOrsxyhoDDeyw9yVLF5EjhIO8O
 wsQ928qr/kaFxklu3Ke/xiOVXbtPKUYQGGU/9Jp7U45soOu3dk/jSrlchhlIxBEcdQZneDZNC
 AWGWDtXLQ267yH5bWIIJMe5kN7J4tVnWvPbFdbRyIqrhx+D6HwVVrZWtJg+aP55RBhEyLlQAT
 1ApSenbxAwiRRt6OFV4J7Z5u7Dfub2ZIwTMnYLEYpIqeOAXcoROs31Gbz5CU10eysvW856GAr
 +V2G47+5i9uvVchlQv2LNKnakxXoeSGXDjqLrNZEu4bI1dz6F8e3+Cr5FUih6xMmkh+qTF23t
 M4g3BB+IS1OwxTf2iC4ACflw9HB377LmwdOMlXOjMy/2Jj+jxDEIX6X6Eut+7K
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 12, 2018, at 11:33 PM, Qian Cai <cai@gmx.us> wrote:
> 
> 
> 
>> On Nov 10, 2018, at 9:11 AM, Qian Cai <cai@gmx.us> wrote:
>> 
>> On 11/10/18 at 8:59 AM, Waiman Long wrote:
>> 
>>> On 11/09/2018 08:45 PM, Qian Cai wrote:
>>>>> Sent: Friday, November 09, 2018 at 5:08 PM
>>>>> From: "Waiman Long" <longman@redhat.com>
>>>>> To: "Qian Cai" <cai@gmx.us>, "Yang Shi" <yang.shi@linux.alibaba.com>
>>>>> Cc: "open list" <linux-kernel@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Arnd Bergmann" <arnd@arndb.de>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Zhong Jiang" <zhongjiang@huawei.com>
>>>>> Subject: Re: ODEBUG: Out of memory. ODEBUG disabled
>>>>> 
>>>>> On 11/09/2018 04:51 PM, Qian Cai wrote:
>>>>>>> On Nov 9, 2018, at 4:42 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>>> On 11/9/18 1:36 PM, Qian Cai wrote:
>>>>>>>> It is a bit annoying on this aarch64 server with 64 CPUs that is
>>>>>>>> booting the latest mainline (3541833fd1f2) causes object debugging
>>>>>>>> always running out of memory.
>>>>>>> May you please paste the detail failure log?
>>>>>> I assume you mean dmesg.
>>>>>> 
>>>>>> Here is the dmesg for 64 CPUs,
>>>>>> https://paste.ubuntu.com/p/BnhvXXhn7k/
>>>>>>>> I have to boot the kernel with only 16 CPUs instead (nr_cpus=16)
>>>>>>>> to make it work. Is it expected that object debugging is not going
>>>>>>>> to work with large machines?
>>>>>>> I don't think so. I'm supposed it works well with large CPU number on x86.
>>>>>> Here is the one with nr_cpus workaround,
>>>>>> https://paste.ubuntu.com/p/qMpd2CCPSV/
>>>>> The debugobjects code have a set of 1024 statically allocated debug
>>>>> objects that can be used in early boot before the slab memory allocator
>>>>> is initialized. Apparently, the system may have used up all the
>>>>> statically allocated objects. Try double ODEBUG_POOL_SIZE to see if it
>>>>> helps.
>>>> Great, you are right. Doubling the size makes it work. Does it make sense
>>>> to have a kconfig option instead?
>>> 
>>> First, I think you need to figure out what your system needed to use up
>>> so many debug objects in early boot. If there is a legitimate reason for
>>> this behavior, we can talk about having a kconfig option to increase that.
>> Anybody else not getting ODEBUG OOM with more than 64-CPU? As
>> mentioned, restricting to 16-CPU works fine. How can I figure out why the
>> system uses so much debug objects?
> On another aarch64 server with 256-CPU, even double the size of
> ODEBUG_POOL_SIZE, i.e., 2048 will get "ODEBUG: Out of memory. ODEBUG
> disabled”.

OK, here is the problem.

In order to get aarch64 work, the initial ODEBUG_POOL_SIZE on

64-CPU:  need 2048
256-CPU: need 8192 (4096 too small)

This commit 97dd552eb23c

+        * Increase the thresholds for allocating and freeing objects
+        * according to the number of possible CPUs available in the system.
+        */
+       debug_objects_pool_size += num_possible_cpus() * 32;

Why magic number 32?

It needs to be bigger than that for aarch64.

(2048 + 64 x 32 - 1024) / 64 = 48 (work on 64-cpu)
(4096 + 256 x 32 - 1024) / 256 = 48 (not work on 256-cpu)
(8196 + 256 x 32 - 1024) / 256 = 60 (work on 256-cpu)

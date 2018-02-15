Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033091AbeBOOH7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:07:59 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33522 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032283AbeBOOH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:07:57 -0500
X-Google-Smtp-Source: AH8x224yiAKly67u2r5AkbplsRX6DxA479Hou6wc/qilQX/LdSYjvT7XU1Nyab7ZVMfhYreFsBM8accriLU0UkKoaf4=
MIME-Version: 1.0
In-Reply-To: <CA+oDAx_gxc_=NOa9naEmHJHjs4t3OP2ef29-4-TP2e8S5p_cEg@mail.gmail.com>
References: <CAMet4B62Ni3Q5OzNvxWVpSfiRkWu2K_20xX6sGBZbROK+9-ULg@mail.gmail.com>
 <CA+oDAx-OEk7q7TZ4k8s_q_OWmObCZEwm0irjPSh-a1W0uZwACQ@mail.gmail.com>
 <1C1B9BF4-56EE-473A-9E92-F7E6BD188C25@canonical.com> <CA+oDAx8Gu0g97ivQ2r1EiLQTYZxhnyL-n2Cx+4J9Sztwj8brrw@mail.gmail.com>
 <53F1AA2B-2049-4A7A-AEBC-4C1CA3C15F61@canonical.com> <9654fc1df0d4cc00cf88dbe10188fd0b@mail.gmail.com>
 <CA+oDAx9K31LJtiKvG2EP4As7t_HqXFiAuLCbaSTdrL1YQwO3Uw@mail.gmail.com>
 <781b8fed3ceaa133aa0e451d9bfbee26@mail.gmail.com> <CA+oDAx8A=VXx0nUXZxG7fJTvJzeWL6b1UYFHoB2Dw3h6yKgr3Q@mail.gmail.com>
 <01bf0c0f91e259dacde4c27f3f31c9e6@mail.gmail.com> <CA+oDAx9s1iT2OJRZ0i5FwmhQx9QtJs8qU70wbfP3rGWYERPL6w@mail.gmail.com>
 <CA+oDAx_gxc_=NOa9naEmHJHjs4t3OP2ef29-4-TP2e8S5p_cEg@mail.gmail.com>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Thu, 15 Feb 2018 19:37:56 +0530
Message-ID: <CAMet4B5sE9DuUzRCCdkX=g8E4C0RtZTzDaPaHDz_N8rPNU9VOg@mail.gmail.com>
Subject: Re: tg3 crashes under high load, when using 100Mbits
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanley Hsiao <stanley.hsiao@canonical.com>,
        Tim Chen <tim.chen119@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1FE842u018360

On Mon, Feb 12, 2018 at 10:59 AM, Siva Reddy Kallam
<siva.kallam@broadcom.com> wrote:
> On Fri, Feb 9, 2018 at 10:41 AM, Kai Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Hi Broadcom folks,
>>
>> We are now enabling a new platform with tg3 nic, unfortunately we observed
>> the bug [1] that dated back to 2015.
>> I tried commit 4419bb1cedcd ("tg3: Add workaround to restrict 5762 MRRS to
>> 2048”) but it does’t work.
>>
>> Do you have any idea how to solve the issue?
>>
>> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1447664
>>
>> Kai-Heng
>>
> Thank you for reporting. We will check and update you.
With link aware mode, the clock speed could be slow and boot code does not
complete within the expected time with lower link speeds. Need to override
and the clock in driver. We are checking the feasibility of adding
this in driver or firmware.

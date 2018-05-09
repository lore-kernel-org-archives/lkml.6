Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933608AbeEIC21 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 22:28:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:26175 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932526AbeEIC2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 22:28:25 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180509022823epoutp01cac09fc30ca228f5448b0ab53b9204db~s2PD49Grx0340003400epoutp01b
X-AuditID: b6c32a47-bc7ff70000001011-27-5af25cc4bcd9
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AF25CC3.1010902@samsung.com>
Date: Wed, 09 May 2018 11:28:19 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: John Stultz <john.stultz@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc: Leo Yan <leo.yan@linaro.org>, Jean Wangtao <kevin.wangtao@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Userland breakage from
 "Modify the device name as devfreq(X) for sysfs"
In-reply-to: <CALAqxLVJekViPWi4kh2JOQ46XXtTv2-2BXOe9O8AvfnvX9Z+Sw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmqe6RmE9RBqv2sFo0L17PZnHmt67F
        rO3H2S3ONr1ht5i89RKbxeVdc9gsbjeuYHNg97hzbQ+bx/65a9g9+rasYvT4vEkugCUq1SYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1StKGhkZ6hgbmekRGQNo61MjIFKklIzbj5+xxrwTLpih2H
        mlgaGFeIdTFyckgImEi8mTuVsYuRi0NIYAejxJ/7m1ghnO+MEs0vjrLBVE2ds5UFIrGBUWL6
        wVOMIAleAUGJH5PvASU4OJgF5CWOXMoGCTMLaEq8+DIJqv4uo0Tr9r9gNbwCWhJbFhWC1LAI
        qEpMfLaaCcRmAwrvf3EDbBe/gKLE1R+PwcaLCkRI7Jz/jR3EFhGok+i/1M8EMpNZYBqjRM+9
        N2BFwgJhEpe/XQJr5hQIluhefpYJ4ugjbBLLP6ZC2C4Sjz/+Z4awhSVeHd/CDmFLSzxbtRHs
        fQmBdkaJ9r3zmCGcKYwS567fg5pkLPFsYRcTxGt8Eh2H/7KDfCMhwCvR0SYEUeIhcXf1LEYI
        21Hi55GnTBDfL2GU2HekgX0Co9wspACbhQiwWUgBtoCReRWjWGpBcW56arFRgbFecWJucWle
        ul5yfu4mRnCa03LfwbjtnM8hRgEORiUeXomdH6OEWBPLiitzDzFKcDArifDKGn+KEuJNSays
        Si3Kjy8qzUktPsRoCgzwicxSosn5wBScVxJvaGpkbGxsYWpuaWxgqSTO2+B7JkpIID2xJDU7
        NbUgtQimj4mDU6qBsXWbkdnLB3eCNPy9I1JkFXimvDH7yVv/atYrqTPHGKUreupunhVQ1m/g
        +WI8yTVSONPxHsf8S/f+HfJz7OhVfiXkcm+Of5/OjbO3Kk7smBmokGE6JTfz5y2p6B2XKldp
        KJ14n7Ss+2mRgdIOj+6qbfpdtpWFy55M3vE+c4LslKf9PcqPNzY8VGIpzkg01GIuKk4EACgt
        6aiJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsVy+t9jQd3DMZ+iDLbvM7VoXryezeLMb12L
        WduPs1ucbXrDbjF56yU2i8u75rBZ3G5cwebA7nHn2h42j/1z17B79G1ZxejxeZNcAEsUl01K
        ak5mWWqRvl0CV8bN3+dYC5ZJV+w41MTSwLhCrIuRk0NCwERi6pytLF2MXBxCAusYJc6tuMME
        kuAVEJT4MfkeUIKDg1lAXuLIpWwIU11iypRciPL7jBJ9Eyezg8R5BbQktiwqBOlkEVCVmPhs
        NdgUNqDw/hc32EBsfgFFias/HjOClIsKREh0n6gEGSMi0MAosfT8PmYQh1lgGqNEz+/HYM3C
        AmESl79dYoNYtgzotu2PwBKcAsES3R82Mk1gFJiF5NRZCKfOQjh1ASPzKkbJ1ILi3PTcYqMC
        o7zUcr3ixNzi0rx0veT83E2MwODedlirfwfj4yXxhxgFOBiVeHgldn6MEmJNLCuuzD3EKMHB
        rCTCK2v8KUqINyWxsiq1KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QD
        o07ll3YOI7dZTS+rLnStazPoZ73e/fhOpujPfT2em+/618x0/3Hj6Jrtz34dtIzIkJbKYDgS
        nfKoKeF3w8aZhodf+ZgcfXom8X7GEhvbsyrxqveCX/IsEzvrqMN+w+Cn5CbeuXsZVZ76qsb8
        WOA/TeZG2uODsy2kVbb4Mk8+tTVbuW+1z8wDKkosxRmJhlrMRcWJAH2uB4JqAgAA
X-CMS-MailID: 20180509022819epcas2p126700f186f0679b990dd7ab5f0702e53
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180508231744epcas2p1251a2e35591e9d2624337d4c8f1d6974
X-RootMTR: 20180508231744epcas2p1251a2e35591e9d2624337d4c8f1d6974
References: <CGME20180508231744epcas2p1251a2e35591e9d2624337d4c8f1d6974@epcas2p1.samsung.com>
        <CALAqxLVJekViPWi4kh2JOQ46XXtTv2-2BXOe9O8AvfnvX9Z+Sw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2018년 05월 09일 08:17, John Stultz wrote:
> Hey folks,
>   I wanted to bring up an issue we've recently tripped over, which was
> caused by 4585fbcb5331f ("PM / devfreq: Modify the device name as
> devfreq(X) for sysfs").
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=4585fbcb5331fc910b7e553ad3efd0dd7b320d14
> 
> That patch replaced paths like:
>    /sys/class/devfreq/ddr_devfreq/min_freq
> and
>   /sys/class/devfreq/e82c0000.mali/min_freq
> 
> With
>   /sys/class/devfreq/devfreq(0)/min_freq
> and
>   /sys/class/devfreq/devfreq(1)/min_freq
> 
> 
> This broke userspace we have that needs to work on 4.4, 4.9 and 4.14 (and on).

Firstly, I'm sorry to make some problem on userland.

> 
> I wanted to try to ask to understand more about the rational for this
> patch, as it doesn't make much sense to me, particularly as now it is
> less obvious as to which path is for which device  - and more
> worrisome it could change depending on initialization order.

Some linux framework used the their own prefix under "/sys/class/"
for device such as input/pwm/hwmon/regulator and so on.
(But, some linux framework used the device name directly without any changes)

I thought that devfreq better to use use the consistent name.
If user wanted to access the specific device with device name,
the user can access the path of '/sys/devices/platform/...'.

[Example on Exynos5433-based TM2 board]
root@localhost:~# ls -al /sys/class/devfreq
total 0
drwxr-xr-x  2 root root 0 Jul 26 04:49 .
drwxr-xr-x 50 root root 0 Jan  1  1970 ..
lrwxrwxrwx  1 root root 0 Jul 26 04:49 devfreq0 -> ../../devices/platform/soc/soc:bus0/devfreq/devfreq0
lrwxrwxrwx  1 root root 0 Jul 26 04:49 devfreq1 -> ../../devices/platform/soc/soc:bus1/devfreq/devfreq1
(skip)

- User can access the devfreq device with specific device name.
root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# pwd
/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0

root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# ls
available_frequencies  device    min_freq          subsystem    uevent
available_governors    governor  polling_interval  target_freq
cur_freq               max_freq  power             trans_stat

root@localhost:/sys/devices/platform/soc/soc:bus0/devfreq/devfreq0# cat min_freq 
160000000


But, there is one of my mistake. The /sys/class/devfreq/devfreq(X)
doesn't have the 'name' attribute. So, the user cannot find the required
device. It is my mistake. I'll add the 'name' attribute as following:
- /sys/class/devfreq/devfreqX/name

> 
> Unfortunately, this wasn't noticed very quickly, as the patch has been
> upstream now for some time.  But I wanted to better understand why
> this change was made, and see if we might consider reverting it, or
> alternatively consider provide multiple sysfs links (both dev_name and
> devfreq(N)) so that we can preserve compatibility?

Unfortunately, there are no frameworks which provide the both dev_name and
[defined prefix](N) link under /sys/class/. I'm not sure this way.

As you comment, devfreq(number) is not fixed as the initialization order.
After adding the 'name' attribute, the user can find the specific device.

How about using the 'name' attribute to find the device
after adding new 'name' attribute when access device through /sys/class?


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

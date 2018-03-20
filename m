Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeCTGLO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:11:14 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:42833 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTGLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:11:08 -0400
X-Google-Smtp-Source: AG47ELsP5FmLpyxFlAG1blf/73CF8LYNgDsXK4HKXxNqJcxOpp68/K/ukVmG0wvMc6JiQCvUKEqR/0tJkwTvO8zZNBk=
MIME-Version: 1.0
From: Satish Baddipadige <satish.baddipadige@broadcom.com>
Date: Tue, 20 Mar 2018 11:41:06 +0530
Message-ID: <CA+oDAx8CCW8rUfdqSZJpKFzHUBocY_Q1xbJXB0y8qa6qP0iUAg@mail.gmail.com>
Subject: Re: NETDEV WATCHDOG: eth0 (tg3): transmit queue 0 timed out
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000aa7e280567d1f0df"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000aa7e280567d1f0df
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 28, 2018 at 7:40 PM, Siva Reddy Kallam
<siva.kallam@broadcom.com> wrote:
> On Sat, Feb 24, 2018 at 3:48 PM, Borislav Petkov <bp@alien8.de> wrote:
>> Hi,
>>
>> this didn't happen before but after 4.16-rc1 my tg3 nic stops for
>> whatever reason and the connection to the machine is dead. It didn't show
>> anything in dmesg until today.
>>
>> The IO pagefaults look like it is trying to access something it
>> shouldn't and maybe that's why it times out.
>>
>> It triggers pretty quickly so I'd call it a reliable reproducer and thus
>> I can test patches... :-)
>>
>> Thx.
> Thanks for reporting this. Somehow, this mail moved to my spam folder.
> Hence, delay in response.
> Looks like this is similar to below issue and it was reported some time back.
> https://www.spinics.net/lists/netdev/msg482757.html
> We are actively working on this. We will soon provide you an update on this.

Hi Borislav,

Can you please test the attached patch?

Thanks,
Satish

--000000000000aa7e280567d1f0df
Content-Type: application/octet-stream; name="tg3_5762_clock_override.patch"
Content-Disposition: attachment; filename="tg3_5762_clock_override.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jez9g8bi0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL3RnMy5jIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vdGczLmMKaW5kZXggZjI1OTM5Ny4uZDI3MzM3ZCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vdGczLmMKKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vdGczLmMKQEAgLTkwMTAsNiArOTAxMCw3IEBAIHN0YXRp
YyB2b2lkIHRnM19vdmVycmlkZV9jbGsoc3RydWN0IHRnMyAqdHApCiAKIAlzd2l0Y2ggKHRnM19h
c2ljX3Jldih0cCkpIHsKIAljYXNlIEFTSUNfUkVWXzU3MTc6CisJY2FzZSBBU0lDX1JFVl81NzYy
OgogCQl2YWwgPSB0cjMyKFRHM19DUE1VX0NMQ0tfT1JJREVfRU5BQkxFKTsKIAkJdHczMihURzNf
Q1BNVV9DTENLX09SSURFX0VOQUJMRSwgdmFsIHwKIAkJICAgICBURzNfQ1BNVV9NQUNfT1JJREVf
RU5BQkxFKTsKQEAgLTkwMzEsNiArOTAzMiw3IEBAIHN0YXRpYyB2b2lkIHRnM19yZXN0b3JlX2Ns
ayhzdHJ1Y3QgdGczICp0cCkKIAogCXN3aXRjaCAodGczX2FzaWNfcmV2KHRwKSkgewogCWNhc2Ug
QVNJQ19SRVZfNTcxNzoKKwljYXNlIEFTSUNfUkVWXzU3NjI6CiAJCXZhbCA9IHRyMzIoVEczX0NQ
TVVfQ0xDS19PUklERV9FTkFCTEUpOwogCQl0dzMyKFRHM19DUE1VX0NMQ0tfT1JJREVfRU5BQkxF
LAogCQkgICAgIHZhbCAmIH5URzNfQ1BNVV9NQUNfT1JJREVfRU5BQkxFKTsK
--000000000000aa7e280567d1f0df--

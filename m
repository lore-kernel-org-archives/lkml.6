Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbeCOPW7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:22:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53618 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751840AbeCOPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:22:58 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "olof@lixom.net" <olof@lixom.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] STi DT update for v4.17 round 2
Thread-Topic: [GIT PULL] STi DT update for v4.17 round 2
Thread-Index: AQHTvDzXpYopfEu1o0+2IKDEW9xFQaPRUzSAgAAGZQA=
Date: Thu, 15 Mar 2018 15:22:24 +0000
Message-ID: <36e374f8-cfc9-06bb-f496-296a145d5b6d@st.com>
References: <af473935-7cb6-e59a-3b52-055d8492248c@st.com>
 <CAK8P3a1R6CwHC4+0GXKevmgM9QqgbGGZCtLsccn2AYTpuHZ7uw@mail.gmail.com>
In-Reply-To: <CAK8P3a1R6CwHC4+0GXKevmgM9QqgbGGZCtLsccn2AYTpuHZ7uw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <25F80EED66707F4B9664E8C66F97E657@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2FFN6hB014925

Hi Arnd

On 03/15/2018 03:59 PM, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 10:06 AM, Patrice CHOTARD
> <patrice.chotard@st.com> wrote:
>> Hi Arnd, Kevin, Olof
>>
>> PLease consider this second round of STi dts update for v4.17
>>
>> The following changes since commit 0e04ce02e6a2ac30d21294d8bb2aeceb8489e52b:
>>
>>     ARM: dts: STi: Remove unused clk_ext2f_a9 clock (2018-02-13 13:31:38
>> +0100)
>>
>> are available in the git repository at:
>>
>>     git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
>>
>> for you to fetch changes up to 9a5f4879cd8de167e82f335317c63f2ffdc80129:
>>
>>     ARM: dts: stih4xx: Add missing #sound-dai-cells (2018-03-15 09:52:25
>> +0100)
>>
>> ----------------------------------------------------------------
>>
>> STi DT update:
>>
>> Add missing #sound-dai-cells which fix DT dtc warnings when building
>> with W=1
> 
> You missed a tag name for this one, but I found tags/sti-dt-for-v4.17-round2
> to be the one that matches the commit ID above and pulled that.
> 
>        Arnd
> 

Sorry for that.
I will check that point, i noticed that i got the same issue with the 
previous pull request for STi DT.

Thanks

Patrice

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeCWHj3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:39:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25809 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751866AbeCWHjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:39:24 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the arm-soc tree
Thread-Index: AQHTvKAyo3qIygEQDEuiV6CRqIxuK6PRuPWAgACvWYCACk+lAIAAsfiA
Date: Fri, 23 Mar 2018 07:38:43 +0000
Message-ID: <e8eefe22-c1d1-d27b-68bb-036f6abb9814@st.com>
References: <20180316075629.019b6560@canb.auug.org.au>
 <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
 <6b239ab5-5ded-b32b-eefc-601075d33f25@st.com>
 <20180322210144.GB3417@piout.net>
In-Reply-To: <20180322210144.GB3417@piout.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E009E61569CF64C8248A6B5F8859245@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-23_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2N7dZPY019860

On 03/22/2018 10:01 PM, Alexandre Belloni wrote:
> On 16/03/2018 at 07:34:06 +0000, Patrice CHOTARD wrote:
>> Hi Arnd, Stephen
>>
>> On 03/15/2018 10:06 PM, Arnd Bergmann wrote:
>>> On Thu, Mar 15, 2018 at 9:56 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>> Hi all,
>>>>
>>>> Commit
>>>>
>>>>     9a5f4879cd8d ("ARM: dts: stih4xx: Add missing #sound-dai-cells")
>>>>
>>>> is missing a Signed-off-by from its committer.
>>>
>>> Thanks for the report.
>>>
>>> What script do you use to find those? I guess I should check for
>>> missing signoffs as well when pulling a branch.
>>>
>>> Patrice, I've dropped the merge now, and picked up the one
>>> patch in it directly, with my signoff. This should fix the issue this
>>> time, but please make sure you always sign off patches when
>>> you apply them from the list.
>>>
>>>           Arnd
>>>
>>
>> Ok i will update my script on my side with Stephen's script to avoid
>> this in the future.
>>
> 
> FWIW, last time this happened in the at91 tree, I've switched to use
> Stephen's script as a pre-push hook:
> https://raw.githubusercontent.com/alexandrebelloni/tools/master/pre-push_signed-off
> 
> 

Thanks Alexandre

Patrice

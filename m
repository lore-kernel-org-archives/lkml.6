Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeCPHem (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:34:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33591 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750767AbeCPHek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:34:40 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>
CC: Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the arm-soc tree
Thread-Index: AQHTvKAyo3qIygEQDEuiV6CRqIxuK6PRuPWAgACvWYA=
Date: Fri, 16 Mar 2018 07:34:06 +0000
Message-ID: <6b239ab5-5ded-b32b-eefc-601075d33f25@st.com>
References: <20180316075629.019b6560@canb.auug.org.au>
 <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
In-Reply-To: <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C02AE0474E70D44A33672C9D6F36D3B@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2G7YkB7030617

Hi Arnd, Stephen

On 03/15/2018 10:06 PM, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 9:56 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> Commit
>>
>>    9a5f4879cd8d ("ARM: dts: stih4xx: Add missing #sound-dai-cells")
>>
>> is missing a Signed-off-by from its committer.
> 
> Thanks for the report.
> 
> What script do you use to find those? I guess I should check for
> missing signoffs as well when pulling a branch.
> 
> Patrice, I've dropped the merge now, and picked up the one
> patch in it directly, with my signoff. This should fix the issue this
> time, but please make sure you always sign off patches when
> you apply them from the list.
> 
>          Arnd
> 

Ok i will update my script on my side with Stephen's script to avoid 
this in the future.

Thanks

Patrice
